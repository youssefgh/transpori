/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.ejb.dao.impl.DaoTransportationLineImpl;
import com.transportation.transportation.model.dtos.TransportationPath;
import com.transportation.transportation.model.dtos.TransportationRequest;
import com.transportation.transportation.model.dtos.TransportationResponse;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
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

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.APPLICATION_JSON)
    public TransportationResponse getJsons(TransportationRequest transportationRequest) {
        List<TransportationLine> transportationLines = daoTransportationLine.readAll();
        List<Station> stations = daoStation.readAll();
        List<Station> originNearbyStations = new ArrayList<>();
        List<Station> destinationNearbyStations = new ArrayList<>();
        //TODO Oopify
        Double distance = transportationRequest.getOriginPosition().distanceTo(transportationRequest.getDestination());
        Double maxWalkableDistance = distance * 20 / 100;
        Double maxWalkableDistanceToStation = maxWalkableDistance / 2;
        for (Station station : stations) {
            if (station.isNear(transportationRequest.getOriginPosition(), maxWalkableDistanceToStation)) {
                originNearbyStations.add(station);
            } else {
                if (station.isNear(transportationRequest.getDestination(), maxWalkableDistanceToStation)) {
                    destinationNearbyStations.add(station);
                }
            }
        }
        TransportationResponse transportationResponse = new TransportationResponse();
        TransportationPath transportationPath;
        for (Station originStation : originNearbyStations) {
            for (Station destinationStation : destinationNearbyStations) {
                for (TransportationLine transportationLine : transportationLines) {
                    if (transportationLine.isWillPassBy(originStation, destinationStation)) {
                        transportationPath = new TransportationPath();
                        transportationPath.addTransportationLine(transportationLine);
                        transportationResponse.addTransportationPath(transportationPath);
                    }
                }
            }
        }
        return transportationResponse;
    }

}
