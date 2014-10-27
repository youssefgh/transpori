/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.service.ServiceStation;
import com.transportation.transportation.ejb.service.ServiceTransportationLine;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;

/**
 *
 * @author youssef
 */
public class ServiceTransportationResponseImplTest {

    private ServiceTransportationResponseImpl instance;

    @Test
    public void testCreate() throws Exception {
        
    }

    private ServiceTransportationResponseImpl getInstance() {
        ServiceTransportationResponseImpl instance;
        instance = new ServiceTransportationResponseImpl();
        instance.serviceStation = new ServiceStation() {
            List<Station> stations = new ArrayList();

            @Override
            public String create(Station station) {
                station.initId();
                stations.add(station);
                return station.getId();
            }

            @Override
            public void update(Station station) {
                for (int i = 0; i < stations.size(); i++) {
                    Station station1 = stations.get(i);
                    if (station1.getId().equals(station.getId())) {
                        stations.set(i, station);
                        return;
                    }
                }
            }

            @Override
            public void delete(String id) {
                for (int i = 0; i < stations.size(); i++) {
                    Station station1 = stations.get(i);
                    if (station1.getId().equals(id)) {
                        stations.remove(i);
                        return;
                    }
                }
            }

            @Override
            public List<Station> readAll() {
                return new ArrayList<>(stations);
            }
        };
        instance.serviceTransportationLine = new ServiceTransportationLine() {
            List<TransportationLine> transportationLines = new ArrayList<>();

            @Override
            public String create(TransportationLine transportationLine) {
                transportationLine.initId();
                transportationLines.add(transportationLine);
                return transportationLine.getId();
            }

            @Override
            public void update(TransportationLine transportationLine) {
                for (int i = 0; i < transportationLines.size(); i++) {
                    TransportationLine transportationLine1 = transportationLines.get(i);
                    if (transportationLine1.getId().equals(transportationLine.getId())) {
                        transportationLines.set(i, transportationLine);
                        return;
                    }
                }
            }

            @Override
            public void delete(String id) {
                for (int i = 0; i < transportationLines.size(); i++) {
                    TransportationLine transportationLine1 = transportationLines.get(i);
                    if (transportationLine1.getId().equals(id)) {
                        transportationLines.remove(i);
                        return;
                    }
                }
            }

            @Override
            public List<TransportationLine> readAll() {
                return new ArrayList<>(transportationLines);
            }

            @Override
            public TransportationLine read(Object id) {
                for (int i = 0; i < transportationLines.size(); i++) {
                    TransportationLine transportationLine1 = transportationLines.get(i);
                    if (transportationLine1.getId().equals(id)) {
                        return transportationLine1;
                    }
                }
                return null;
            }

            @Override
            public void updateAllStations(Station station) {
                for (TransportationLine transportationLine : transportationLines) {

                }
            }
        };
        return instance;
    }

}
