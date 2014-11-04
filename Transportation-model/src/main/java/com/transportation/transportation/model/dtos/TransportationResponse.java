/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author youssef
 */
public class TransportationResponse implements Serializable {

    private List<TransportationPath> transportationPaths;

    {
        transportationPaths = new ArrayList<>();
    }

    public List<TransportationPath> getTransportationPaths() {
        return transportationPaths;
    }

    public void setTransportationPaths(List<TransportationPath> transportationPaths) {
        this.transportationPaths = transportationPaths;
    }

    public void addTransportationPath(TransportationPath transportationPath) {
        transportationPaths.add(transportationPath);
    }

    public void addTransportationPaths(List<TransportationPath> transportationPaths) {
        this.transportationPaths.addAll(transportationPaths);
    }

    @Deprecated
    public Boolean isHave(TransportationLine transportationLine) {
        for (TransportationPath transportationPath : transportationPaths) {
            if (transportationPath.getTransportationLines().contains(transportationLine)) {
                System.out.println("true!!!!!!!!!!!");
                return true;
            }
        }
        return false;
    }

    @Override
    public String toString() {
        return "TransportationResponse{" + "transportationPaths=" + transportationPaths + '}';
    }

    public static TransportationResponse create(TransportationRequest transportationRequest, List<TransportationLine> transportationLinesD, List<Station> stations) {
        TransportationLines transportationLines = new TransportationLines(transportationLinesD);
        TransportationResponse transportationResponse = new TransportationResponse();
        TransportationPath transportationPath;
        TransportationLine transportationLine;
        MapPoint originPosition = transportationRequest.getOriginPosition();
        MapPoint destination = transportationRequest.getDestination();
        TransportationLines foundTransportationLines = transportationLines.find(originPosition, destination, stations);
        transportationResponse.addTransportationPaths(foundTransportationLines.toTransportationPaths());
        for (int i = 0; i < transportationResponse.getTransportationPaths().size() /*&& i<1*/; i++) {
            transportationPath = transportationResponse.getTransportationPaths().get(i);
            if (originPosition.distanceTo(transportationPath.firstTransportationLine().firstMapPoint()) > 1000D) {
                foundTransportationLines = transportationLines.find(originPosition, transportationPath.firstTransportationLine().firstMapPoint(), stations);
                if (foundTransportationLines.size() == 1) {
                    if (!transportationResponse.isHave(foundTransportationLines.firstTransportationLine())) {
                        transportationPath.addTransportationLineToBegin(foundTransportationLines.firstTransportationLine());
                    }
                } else if (foundTransportationLines.size() > 1) {
                    TransportationPath newTransportationPath;
                    for (int j = 1; j < foundTransportationLines.size(); j++) {
                        transportationLine = foundTransportationLines.get(j);
                        if (!transportationResponse.isHave(transportationLine)) {
                            newTransportationPath = transportationPath.clone();
                            newTransportationPath.addTransportationLineToBegin(transportationLine);
                            transportationResponse.addTransportationPath(newTransportationPath);
                        }
                    }
                }
            }
            if (transportationPath.lastTransportationLine().lastMapPoint().distanceTo(destination) > 1000D) {
                foundTransportationLines = transportationLines.find(transportationPath.lastTransportationLine().lastMapPoint(), destination, stations);
                if (foundTransportationLines.size() == 1) {
                    if (!transportationResponse.isHave(foundTransportationLines.firstTransportationLine())) {
                        transportationPath.addTransportationLine(foundTransportationLines.firstTransportationLine());
                    }
                } else if (foundTransportationLines.size() > 1) {
                    TransportationPath newTransportationPath;
                    for (int j = 1; j < foundTransportationLines.size(); j++) {
                        transportationLine = foundTransportationLines.get(j);
                        if (!transportationResponse.isHave(transportationLine)) {
                            newTransportationPath = transportationPath.clone();
                            newTransportationPath.addTransportationLine(transportationLine);
                            transportationResponse.addTransportationPath(newTransportationPath);
                        }
                    }
                }
            }
        }
        LOG.log(Level.INFO, "TransportationResponse generated with : {0} TransportationPath(s)", transportationResponse.getTransportationPaths().size());
        return transportationResponse;
    }

    private static final Logger LOG = Logger.getLogger(TransportationResponse.class.getName());

}
