/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author youssef
 */
public class TransportationLineTest {

    public TransportationLineTest() {
    }

    @org.junit.Test
    public void testInitId() {
    }

    @org.junit.Test
    public void testGetStations() {
    }

    @org.junit.Test
    public void testGetLastMapPoint() {
        TransportationLine transportationLine = new TransportationLine();
        Station station = new Station(2F, 2F);
        transportationLine.getMapPoints().add(new Station(1F, 1F));
        transportationLine.getMapPoints().add(station);
        assertEquals(transportationLine.getLastMapPoint(), station);
        MapPoint mapPoint = new MapPoint(3F, 3F);
        transportationLine.getMapPoints().add(mapPoint);
        assertEquals(transportationLine.getLastMapPoint(), mapPoint);
    }

    @org.junit.Test
    public void testSetMapPoints() {
    }

    @org.junit.Test
    public void testIsLastStation() {
    }

    @org.junit.Test
    public void testIsWillPassBy_Station() {
        TransportationLine transportationLine = new TransportationLine();
        Station station = new Station(2F, 2F);
        transportationLine.getMapPoints().add(new Station(1F, 1F));
        transportationLine.getMapPoints().add(station);
        transportationLine.getMapPoints().add(new Station(3F, 3F));
        assertTrue(transportationLine.isWillPassBy(station));
    }

    @org.junit.Test
    public void testIsWillPassBy_Station_Station() {
    }

    @org.junit.Test
    public void testRemoveBefore() {
        TransportationLine transportationLine = new TransportationLine();
        Station station1 = new Station();
        station1.setId("1");
        Station station2 = new Station();
        station1.setId("2");
        Station station3 = new Station();
        station1.setId("3");
        transportationLine.getMapPoints().add(station1);
        transportationLine.getMapPoints().add(station2);
        transportationLine.getMapPoints().add(station3);
        transportationLine.removeBefore(station2);
        assertFalse(transportationLine.getMapPoints().isEmpty());
        assertEquals(station2, transportationLine.getMapPoints().get(0));
        assertTrue(transportationLine.getMapPoints().size() == 2);
    }

    @org.junit.Test
    public void testRemoveAfter() {
        TransportationLine transportationLine = new TransportationLine();
        Station station1 = new Station();
        station1.setId("1");
        Station station2 = new Station();
        station1.setId("2");
        Station station3 = new Station();
        station1.setId("3");
        transportationLine.getMapPoints().add(station1);
        transportationLine.getMapPoints().add(station2);
        transportationLine.getMapPoints().add(station3);
        transportationLine.removeAfter(station2);
        assertTrue(transportationLine.getMapPoints().size() == 2);
        assertTrue(transportationLine.getMapPoints().indexOf(station2) == 1);
    }

    @org.junit.Test
    public void testEquals() {
    }

}
