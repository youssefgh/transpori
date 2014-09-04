/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.service.ServiceStation;
import com.transportation.transportation.ejb.service.ServiceTransportationLine;
import com.transportation.transportation.ejb.service.ServiceTransportationResponse;
import com.transportation.transportation.model.dtos.Destination;
import com.transportation.transportation.model.dtos.OriginPosition;
import com.transportation.transportation.model.dtos.TransportationPath;
import com.transportation.transportation.model.dtos.TransportationRequest;
import com.transportation.transportation.model.dtos.TransportationResponse;
import com.transportation.transportation.model.entities.MapPoint;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.ArrayList;
import java.util.List;
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 *
 * @author youssef
 */
public class ServiceTransportationResponseImplTest {

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @Before
    public void setUp() throws Exception {
    }

    //@Test
    public void testCreate() throws Exception {
        System.out.println("create");
        ServiceTransportationResponseImpl instance = getInstance();
        Station station1 = new Station(1F, 1F);
        Station station2 = new Station(1F, plus(1F, 1000D));
        Station station3 = new Station(1F, plus(station2.getLongitude(), 1000D));
        instance.serviceStation.create(station1);
        instance.serviceStation.create(station2);
        instance.serviceStation.create(station3);

        TransportationLine transportationLine1 = new TransportationLine() {

            @Override
            public TransportationLine clone() {
                throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
            }
        };

        transportationLine1.getMapPoints().add(station1);
        transportationLine1.getMapPoints().add(new MapPoint(0F, 0F));
        transportationLine1.getMapPoints().add(station2);
        transportationLine1.getMapPoints().add(new MapPoint(0F, 0F));
        transportationLine1.getMapPoints().add(station3);

        instance.serviceTransportationLine.create(transportationLine1);

        TransportationResponse expResult = new TransportationResponse();
        TransportationPath transportationPath1 = new TransportationPath();
        transportationPath1.addTransportationLine(transportationLine1);
        expResult.addTransportationPath(transportationPath1);

        TransportationRequest transportationRequest = new TransportationRequest();
        transportationRequest.setOriginPosition(new OriginPosition(1F, plus(1F, -500D)));
        transportationRequest.setDestination(new Destination(1F, plus(station2.getLongitude(), 500D)));
        TransportationResponse result = instance.create(transportationRequest);
        assertEquals(result.getTransportationPaths().get(1).getTransportationLines().get(1), transportationLine1);
        assertEquals(result.getTransportationPaths().get(1).getTransportationLines().get(1).getFirstMapPoint(), transportationLine1.getFirstMapPoint());
        assertEquals(result.getTransportationPaths().get(1).getTransportationLines().get(1).getLastMapPoint(), transportationLine1.getLastMapPoint());
    }

    private ServiceTransportationResponseImpl getInstance() {
        ServiceTransportationResponseImpl instance;
        instance = new ServiceTransportationResponseImpl();
        instance.serviceStation = new ServiceStation() {
            List<Station> stations;

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
            List<TransportationLine> transportationLines;

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

    @Test
    public void testPlus() {
        final Double avgDistance = new MapPoint(1F, 1F).distanceTo(new MapPoint(1F, 1F + 1));
        assertTrue(plus(1F, avgDistance) == 2F);
    }

    private Float plus(Float origin, Double distance) {
        Double longitudeDistance = new MapPoint(1F, origin).distanceTo(new MapPoint(1F, origin + 1));
        Double meterLongitudeDistance = 1 / longitudeDistance;
        Double value = origin + meterLongitudeDistance * distance;
        return value.floatValue();
    }
}
