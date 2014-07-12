/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.model.dtos.Destination;
import com.transportation.transportation.model.dtos.OriginPosition;
import com.transportation.transportation.model.dtos.TransportationPath;
import com.transportation.transportation.model.dtos.TransportationRequest;
import com.transportation.transportation.model.dtos.TransportationResponse;
import com.transportation.transportation.model.entities.MapPoint;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("TransportationResponse")
@RequestScoped
public class TransportationResponseResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoTransportationLine daoTransportationLine;

    @EJB
    private DaoStation daoStation;
    private List<TransportationLine> transportationLines;
    private List<Station> stations;

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.APPLICATION_JSON)
    public TransportationResponse getJsons(TransportationRequest transportationRequest) {
        transportationLines = daoTransportationLine.readAll();
        stations = daoStation.readAll();
        TransportationResponse transportationResponse;
        TransportationPath transportationPath;
        transportationResponse = new TransportationResponse();
        MapPoint originPosition = transportationRequest.getOriginPosition();
        MapPoint destination = transportationRequest.getDestination();
        List<TransportationLine> foundTransportationLines = find(originPosition, destination);
        System.out.println("found s " + foundTransportationLines.size());
        for (TransportationLine transportationLine : foundTransportationLines) {
            if (!transportationResponse.isHave(transportationLine)) {
                transportationPath = new TransportationPath();
                transportationPath.addTransportationLine(transportationLine);
                transportationResponse.addTransportationPath(transportationPath);
            }
        }
        for (int i = 0; i < transportationResponse.getTransportationPaths().size(); i++) {
            transportationPath = transportationResponse.getTransportationPaths().get(i);
            if (transportationPath.getTransportationLines().get(0).getFirstMapPoint().distanceTo(originPosition) > 1000D) {
                int size = transportationPath.getTransportationLines().size();
                foundTransportationLines = find(originPosition, transportationPath.getTransportationLines().get(0).getMapPoints().get(0));
                keepDistinct(foundTransportationLines);
                if (foundTransportationLines.size() == 1) {
                    for (TransportationLine transportationLine : foundTransportationLines) {
                        if (!transportationResponse.isHave(transportationLine)) {
                            transportationPath.addTransportationLine(transportationLine);
                        }
                    }
                    if (size < transportationPath.getTransportationLines().size()) {
                        transportationPath.getTransportationLines().add(0, transportationPath.getTransportationLines().get(size));
                        transportationPath.getTransportationLines().remove(size + 1);
                    }
                } else if (foundTransportationLines.size() > 1) {
                    TransportationPath oldTransportationPath = new TransportationPath(transportationPath);
                    transportationPath.getTransportationLines().add(0,foundTransportationLines.get(0));
                    TransportationPath newTransportationPath;
                    for (int j = 1; j < foundTransportationLines.size(); j++) {
                        TransportationLine transportationLine = foundTransportationLines.get(j);
                        if (!transportationResponse.isHave(transportationLine)) {
                            newTransportationPath = new TransportationPath(oldTransportationPath);
                            newTransportationPath.getTransportationLines().add(0,transportationLine);
                            transportationResponse.addTransportationPath(newTransportationPath);
                        }
                    }
                }
            }
            if (transportationPath.getLastMapPoint().distanceTo(destination) > 1000D) {
                foundTransportationLines = find(transportationPath.getLastMapPoint(), destination);
                keepDistinct(foundTransportationLines);
                if (foundTransportationLines.size() == 1) {
                    for (TransportationLine transportationLine : foundTransportationLines) {
                        if (!transportationResponse.isHave(transportationLine)) {
                            transportationPath.addTransportationLine(transportationLine);
                        }
                    }
                } else if (foundTransportationLines.size() > 1) {
                    TransportationPath oldTransportationPath = new TransportationPath(transportationPath);
                    transportationPath.addTransportationLine(foundTransportationLines.get(0));
                    TransportationPath newTransportationPath;
                    for (int j = 1; j < foundTransportationLines.size(); j++) {
                        TransportationLine transportationLine = foundTransportationLines.get(j);
                        if (!transportationResponse.isHave(transportationLine)) {
                            newTransportationPath = new TransportationPath(oldTransportationPath);
                            newTransportationPath.addTransportationLine(transportationLine);
                            transportationResponse.addTransportationPath(newTransportationPath);
                        }
                    }
                }
            }
        }
        System.out.println(transportationResponse.getTransportationPaths().size());
        return transportationResponse;
    }

    List<TransportationLine> find(MapPoint originPosition, MapPoint destination
    ) {
        List<TransportationLine> foundTransportationLines = new ArrayList<>();
        Double distance = originPosition.distanceTo(destination);
        Double SearchDistance = distance / 4;
        List<Station> originNearbyStations = findNearbyStations(originPosition, SearchDistance);
        for (Station originNearbyStation : originNearbyStations) {
            List<TransportationLine> passByLines = findPassByLines(originNearbyStation);
            for (TransportationLine transportationLine : passByLines) {
                Station nearestStation = null;
                List<Station> tRStations = transportationLine.getStations();
                for (Station station : tRStations) {
                    if (station.isNear(destination, SearchDistance)) {
                        if (nearestStation == null || nearestStation.distanceTo(destination) > station.distanceTo(destination)) {
                            nearestStation = station;
                        }
                    }
                }
                if (nearestStation != null && nearestStation.isNear(destination, SearchDistance)) {
                    transportationLine.removeBefore(originNearbyStation);
                    transportationLine.removeAfter(nearestStation);
                    if (!transportationLine.getMapPoints().isEmpty()) {
                        foundTransportationLines.add(transportationLine);
                    }
                }
            }
        }
        return foundTransportationLines;
    }

    private void keepDistinct(List<TransportationLine> transportationLines) {
        for (int j = 0; j < transportationLines.size(); j++) {
            TransportationLine transportationLine = transportationLines.get(j);
            while (transportationLines.indexOf(transportationLine) != transportationLines.lastIndexOf(transportationLine)) {
                transportationLines.remove(transportationLines.lastIndexOf(transportationLine));
            }
        }
    }

    List<Station> findNearbyStations(MapPoint mapPoint, Double distance
    ) {
        List<Station> nearbyStations = new ArrayList<>();
        for (Station station : stations) {
            if (station.isNear(mapPoint, distance)) {
                nearbyStations.add(station);
                for (int i = 0; i < nearbyStations.size() - 1; i++) {
                    Station station1 = nearbyStations.get(i);
                    if (station1.distanceTo(mapPoint) > station.distanceTo(mapPoint)) {
                        nearbyStations.add(i, station);
                        nearbyStations.remove(nearbyStations.size() - 1);
                        break;
                    }
                }
            }
        }
        return nearbyStations;
    }

    List<TransportationLine> findPassByLines(Station station
    ) {
        List<TransportationLine> passBytransportationLines = new ArrayList<>();
        for (TransportationLine transportationLine : transportationLines) {
            if (transportationLine.isWillPassBy(station)) {
                passBytransportationLines.add(daoTransportationLine.read(transportationLine.getId()));
            }
        }
        return passBytransportationLines;
    }
}
