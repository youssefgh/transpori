/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.service.ServiceStation;
import com.transportation.transportation.ejb.service.ServiceTransportationLine;
import com.transportation.transportation.ejb.service.ServiceTransportationResponse;
import com.transportation.transportation.model.dtos.MapPoint;
import com.transportation.transportation.model.dtos.TransportationLines;
import com.transportation.transportation.model.dtos.TransportationPath;
import com.transportation.transportation.model.dtos.TransportationRequest;
import com.transportation.transportation.model.dtos.TransportationResponse;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.List;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class ServiceTransportationResponseImpl implements ServiceTransportationResponse {

    //Change from private to public for test purpose
    //TODO find alt
    @EJB
    public ServiceStation serviceStation;
    @EJB
    public ServiceTransportationLine serviceTransportationLine;

    @Override
    public TransportationResponse create(TransportationRequest transportationRequest) {
        TransportationLines transportationLines = new TransportationLines(serviceTransportationLine.readAll());
        List<Station> stations = serviceStation.readAll();
        TransportationResponse transportationResponse = TransportationResponse.create(transportationRequest, transportationLines, stations);
        
//        TransportationResponse transportationResponse = new TransportationResponse();
//        TransportationPath transportationPath;
//        MapPoint originPosition = transportationRequest.getOriginPosition();
//        MapPoint destination = transportationRequest.getDestination();
//        List<TransportationLine> foundTransportationLines = transportationLines.find(originPosition, destination, stations);
//        for (TransportationLine transportationLine : foundTransportationLines) {
//            if (!transportationResponse.isHave(transportationLine)) {
//                transportationPath = new TransportationPath();
//                transportationPath.addTransportationLine(transportationLine);
//                transportationResponse.addTransportationPath(transportationPath);
//            }
//        }
//        for (int i = 0; i < transportationResponse.getTransportationPaths().size(); i++) {
//            transportationPath = transportationResponse.getTransportationPaths().get(i);
//            if (transportationPath.getTransportationLines().get(0).firstMapPoint().distanceTo(originPosition) > 1000D) {
//                int size = transportationPath.getTransportationLines().size();
//                foundTransportationLines = transportationLines.find(originPosition, transportationPath.getTransportationLines().get(0).getMapPoints().get(0), stations);
//                transportationLines.keepDistinct(foundTransportationLines);
//                if (foundTransportationLines.size() == 1) {
//                    for (TransportationLine transportationLine : foundTransportationLines) {
//                        if (!transportationResponse.isHave(transportationLine)) {
//                            transportationPath.addTransportationLine(transportationLine);
//                        }
//                    }
//                    if (size < transportationPath.getTransportationLines().size()) {
//                        transportationPath.getTransportationLines().add(0, transportationPath.getTransportationLines().get(size));
//                        transportationPath.getTransportationLines().remove(size + 1);
//                    }
//                } else if (foundTransportationLines.size() > 1) {
//                    TransportationPath oldTransportationPath = new TransportationPath(transportationPath);
//                    transportationPath.getTransportationLines().add(0, foundTransportationLines.get(0));
//                    TransportationPath newTransportationPath;
//                    for (int j = 1; j < foundTransportationLines.size(); j++) {
//                        TransportationLine transportationLine = foundTransportationLines.get(j);
//                        if (!transportationResponse.isHave(transportationLine)) {
//                            newTransportationPath = new TransportationPath(oldTransportationPath);
//                            newTransportationPath.getTransportationLines().add(0, transportationLine);
//                            transportationResponse.addTransportationPath(newTransportationPath);
//                        }
//                    }
//                }
//            }
//            if (transportationPath.getLastMapPoint().distanceTo(destination) > 1000D) {
//                foundTransportationLines = transportationLines.find(transportationPath.getLastMapPoint(), destination, stations);
//                transportationLines.keepDistinct(foundTransportationLines);
//                if (foundTransportationLines.size() == 1) {
//                    for (TransportationLine transportationLine : foundTransportationLines) {
//                        if (!transportationResponse.isHave(transportationLine)) {
//                            transportationPath.addTransportationLine(transportationLine);
//                        }
//                    }
//                } else if (foundTransportationLines.size() > 1) {
//                    TransportationPath oldTransportationPath = new TransportationPath(transportationPath);
//                    transportationPath.addTransportationLine(foundTransportationLines.get(0));
//                    TransportationPath newTransportationPath;
//                    for (int j = 1; j < foundTransportationLines.size(); j++) {
//                        TransportationLine transportationLine = foundTransportationLines.get(j);
//                        if (!transportationResponse.isHave(transportationLine)) {
//                            newTransportationPath = new TransportationPath(oldTransportationPath);
//                            newTransportationPath.addTransportationLine(transportationLine);
//                            transportationResponse.addTransportationPath(newTransportationPath);
//                        }
//                    }
//                }
//            }
//        }
//        LOG.log(Level.INFO, "TransportationResponse generated with : {0} TransportationPath(s)", transportationResponse.getTransportationPaths().size());
        return transportationResponse;
    }

    private List<TransportationPath> searchPaths() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private static final Logger LOG = Logger.getLogger(ServiceTransportationResponseImpl.class.getName());

}
