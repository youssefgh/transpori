/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.BusLine;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TrainLine;
import com.transportation.transportation.model.entities.TramwayLine;
import com.transportation.transportation.model.entities.TransportationLine;
import com.transportation.transportation.model.entities.TransportationLineTest;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;
import static org.junit.Assert.*;
import static com.transportation.transportation.model.helper.SearchHelper.*;

/**
 *
 * @author youssef
 */
public class TransportationLinesTest {

    @Test
    public void testFind() throws Exception {
        System.out.println("testFind");
        List<Station> stations = new ArrayList<>();
        TransportationLines instance = new TransportationLines();

        Station station1 = new Station(ORIGIN, ORIGIN);
        Station station2 = new Station(ORIGIN, plus(ORIGIN, 1000D));
        Station station3 = new Station(ORIGIN, plus(station2.getLongitude(), 1000D));
        Station station4 = new Station(ORIGIN, plus(ORIGIN, -499D));
        Station station5 = new Station(ORIGIN, plus(station3.getLongitude(), 499D));
        station1.initId();
        station2.initId();
        station3.initId();
        station4.initId();
        station5.initId();
        stations.add(station1);
        stations.add(station2);
        stations.add(station3);
        stations.add(station4);
        stations.add(station5);

        TransportationLine transportationLine1 = new BusLine();
        TransportationLine transportationLine2 = new TrainLine();
        TransportationLine transportationLine3 = new TramwayLine();

        transportationLine1.initId();
        transportationLine2.initId();
        transportationLine3.initId();

        transportationLine1.addMapPoint(station1);
        transportationLine1.addMapPoint(new MapPoint(0F, 0F));
        transportationLine1.addMapPoint(station2);
        transportationLine1.addMapPoint(new MapPoint(0F, 0F));
        transportationLine1.addMapPoint(station3);
        transportationLine2.addMapPoint(station4);
        transportationLine2.addMapPoint(new MapPoint(0F, 0F));
        transportationLine2.addMapPoint(station5);

        instance.add(transportationLine1);

        System.out.println("test 1 transportationLine ");
        MapPoint originPosition;
        MapPoint destination;
        List<TransportationLine> result;

        System.out.println("full mapPoints");
        originPosition = new MapPoint(ORIGIN, plus(ORIGIN, -750D));
        destination = new MapPoint(ORIGIN, plus(station3.getLongitude(), 750D));
        result = instance.find(originPosition, destination, stations);
        assertEquals(result.get(0), transportationLine1);
        System.out.println(result.get(0).getMapPoints().size());
        assertEquals(result.get(0).firstMapPoint(), transportationLine1.firstMapPoint());
        assertEquals(result.get(0).lastMapPoint(), transportationLine1.lastMapPoint());

        System.out.println("point far from destination by distance/4 should give 0 result");
        originPosition = new MapPoint(ORIGIN, ORIGIN);
        destination = new MapPoint(ORIGIN, plus(station3.getLongitude(), 700D));
        result = instance.find(originPosition, destination, stations);

        assertEquals(0, result.size());

        System.out.println("point far from originPosition by distance/4 should give 0 result");
        originPosition = new MapPoint(ORIGIN, plus(ORIGIN, -700D));
        destination = new MapPoint(ORIGIN, station3.getLongitude());
        result = instance.find(originPosition, destination, stations);
        assertEquals(0, result.size());

        System.out.println("firsts mapPoints");

        originPosition = new MapPoint(ORIGIN, plus(ORIGIN, -499D));
        destination = new MapPoint(ORIGIN, plus(station2.getLongitude(), 499D));
        result = instance.find(originPosition, destination, stations);
        assertEquals(result.get(0), transportationLine1);
        assertEquals(result.get(0).firstMapPoint(), transportationLine1.firstMapPoint());
        assertEquals(result.get(0).lastMapPoint(), station2);

        System.out.println("lasts mapPoints");

        originPosition = new MapPoint(ORIGIN, plus(station2.getLongitude(), -499D));
        destination = new MapPoint(ORIGIN, plus(station3.getLongitude(), 499D));
        result = instance.find(originPosition, destination, stations);
        assertEquals(result.get(0), transportationLine1);
        assertEquals(result.get(0).firstMapPoint(), station2);
        assertEquals(result.get(0).lastMapPoint(), transportationLine1.lastMapPoint());

        System.out.println("test 2 transportationLine ");

        instance.add(transportationLine2);
        instance.add(transportationLine3);
        
        originPosition = new MapPoint(station1.getLatitude(), station1.getLongitude());
        destination = new MapPoint(station3.getLatitude(), station3.getLongitude());
        result = instance.find(originPosition, destination, stations);
        assertEquals(2, result.size());
        assertEquals(transportationLine1, result.get(0));
        assertEquals(transportationLine2, result.get(1));

        System.out.println("should return distinct transportation lines");
        
        station1 = new Station(ORIGIN, ORIGIN);
        station2 = new Station(ORIGIN, plus(ORIGIN, 1D));
        station3 = new Station(ORIGIN, plus(station2.getLongitude(), 1000D));
        station1.initId();
        station2.initId();
        station3.initId();
        
        stations.clear();
        stations.add(station1);
        stations.add(station2);
        stations.add(station3);
        
        transportationLine1 = new BusLine();
        transportationLine1.addMapPoint(station1);
        transportationLine1.addMapPoint(station2);
        transportationLine1.addMapPoint(station3);
        
        instance.clear();
        instance.add(transportationLine1);
        
        assertEquals(1, instance.find(station1, station3, stations).size());
    }

    @Test
    public void testFindNearbyStations() {
        System.out.println("testFindNearbyStations");

        TransportationLines instance = new TransportationLines();
        Station station1 = new Station(ORIGIN, ORIGIN);
        Station station2 = new Station(ORIGIN, plus(ORIGIN, 1000D));
        Station station3 = new Station(ORIGIN, plus(station2.getLongitude(), 1000D));
        Station station4 = new Station(ORIGIN, plus(station3.getLongitude(), 1000D));
        Station station5 = new Station(ORIGIN, plus(station4.getLongitude(), 1000D));
        Station station6 = new Station(ORIGIN, plus(station5.getLongitude(), 1000D));

        List<Station> stations = new ArrayList<>();
        stations.add(station1);
        stations.add(station2);
        stations.add(station3);
        stations.add(station4);
        stations.add(station5);
        stations.add(station6);

        assertEquals(0, instance.findNearbyStations(new MapPoint(ORIGIN, plus(ORIGIN, -1000D)), 999D, stations).size());
        assertEquals(1, instance.findNearbyStations(new MapPoint(ORIGIN, plus(ORIGIN, -1000D)), 1000D, stations).size());
        assertEquals(2, instance.findNearbyStations(new MapPoint(ORIGIN, ORIGIN), 1000D, stations).size());
        assertEquals(3, instance.findNearbyStations(station2, 1000D, stations).size());
    }

    @Test
    public void testFindPassByLines() {
        System.out.println("testFindPassByLines");

        TransportationLines instance = new TransportationLines();
        Station station1 = new Station(ORIGIN, ORIGIN);
        Station station2 = new Station(ORIGIN, plus(ORIGIN, 1000D));
        Station station3 = new Station(ORIGIN, plus(station2.getLongitude(), 1000D));
        Station station4 = new Station(ORIGIN, plus(station3.getLongitude(), 500D));
        Station station5 = new Station(ORIGIN, plus(station4.getLongitude(), 5000D));
        Station station6 = new Station(ORIGIN, plus(station5.getLongitude(), 1000D));

        station1.initId();
        station2.initId();
        station3.initId();
        station4.initId();
        station5.initId();
        station6.initId();

        TransportationLine transportationLine1 = new BusLine();
        TransportationLine transportationLine2 = new TrainLine();

        transportationLine1.addMapPoint(station1);
        transportationLine1.addMapPoint(new MapPoint(0F, 0F));
        transportationLine1.addMapPoint(station2);
        transportationLine1.addMapPoint(new MapPoint(1F, 1F));
        transportationLine1.addMapPoint(station3);
        transportationLine2.addMapPoint(station3);
        transportationLine2.addMapPoint(station4);
        transportationLine2.addMapPoint(new MapPoint(2F, 2F));
        transportationLine2.addMapPoint(station5);

        instance = new TransportationLines();
        instance.add(transportationLine1);
        instance.add(transportationLine2);

        assertEquals(0, instance.findPassByLines(station6).size());
        assertEquals(1, instance.findPassByLines(station1).size());
        assertEquals(2, instance.findPassByLines(station3).size());
    }

    @Test
    public void testKeepDistinct() {
        System.out.println("testKeepDistinct");

        TransportationLines instance = new TransportationLines();
        TransportationLine transportationLine1 = new BusLine();
        TransportationLine transportationLine2 = new TrainLine();
        TransportationLine transportationLine3 = new TramwayLine();

        transportationLine1.initId();
        transportationLine2.initId();
        transportationLine3.initId();

        instance.add(transportationLine1);
        instance.add(transportationLine2);
        instance.add(transportationLine3);
        instance.add(transportationLine1);
        instance.add(transportationLine2);
        instance.add(transportationLine3);

        instance.keepDistinct();

        assertEquals("should remove duplicated elements based on equals", 3, instance.size());
    }

    @Test
    public void testToTransportationPaths() {
        System.out.println("toTransportationPaths");
        TransportationLines instance = new TransportationLines();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        instance.add(transportationLine1);
        instance.add(transportationLine2);
        List<TransportationPath> result = instance.toTransportationPaths();
        assertEquals(2, result.size());
        assertEquals(transportationLine1, result.get(0).getTransportationLines().get(0));
        assertEquals(transportationLine2, result.get(1).getTransportationLines().get(0));
    }

    
    @Test
    public void testFirstTransportationLine() {
        System.out.println("firstTransportationLine");
        TransportationLines instance = new TransportationLines();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        TransportationLine expResult = transportationLine1;
        instance.add(transportationLine1);
        instance.add(transportationLine2);
        TransportationLine result = instance.firstTransportationLine();
        assertEquals(expResult, result);
    }

    @Test
    public void testLastTransportationLine() {
        System.out.println("lastTransportationLine");
        TransportationLines instance = new TransportationLines();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        TransportationLine expResult = transportationLine2;
        instance.add(transportationLine1);
        instance.add(transportationLine2);
        TransportationLine result = instance.lastTransportationLine();
        assertEquals(expResult, result);
    }

}
