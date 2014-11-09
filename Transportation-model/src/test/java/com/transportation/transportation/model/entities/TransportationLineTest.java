/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import com.transportation.transportation.model.dtos.MapPoint;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 *
 * @author youssef
 */
public class TransportationLineTest {

    private TransportationLine instance;

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void testInitId() {
        instance = new TransportationLineImpl();
        instance.initId();
        assertEquals(24, instance.getId().length());
    }

    @Test
    public void testStations() {
        instance = new TransportationLineImpl();
        instance.addMapPoint(new MapPoint());
        instance.addMapPoint(new Station());
        instance.addMapPoint(new MapPoint());
        instance.addMapPoint(new Station());
        instance.addMapPoint(new MapPoint());
        assertEquals(2, instance.stations().size());
    }

    @Test
    public void testLastMapPoint() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        station1.initId();
        station2.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        assertEquals(instance.lastMapPoint(), station2);
        MapPoint mapPoint = new MapPoint(3F, 3F);
        instance.addMapPoint(mapPoint);
        assertEquals(instance.lastMapPoint(), mapPoint);
    }
    
    @Test
    public void testUpdate() {
        System.out.println("update");
        int i = 0;
        Station station = new Station();
        station.initId();
        station.setName("a");
        instance = new TransportationLineImpl();
        instance.addMapPoint(station);
        Station station1 = new Station(station.getId());
        station1.setName("b");
        assertThat(instance.update(station1), is(true));
        assertEquals(instance.stations().get(0).getName(), "b");
    }

    @Test
    public void testIsLastStation() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        station1.initId();
        station2.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        assertTrue(instance.isLastStation(station2));
    }

    @Test
    public void testIsWillPassBy_Station() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        Station station3 = new Station();
        station1.initId();
        station2.initId();
        station3.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        assertTrue(instance.isWillPassBy(station2));
        assertFalse(instance.isWillPassBy(station3));
    }

    @Test
    public void testIsWillPassBy_Station_Station() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        Station station3 = new Station();
        Station station4 = new Station();
        station1.initId();
        station2.initId();
        station3.initId();
        station4.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        instance.addMapPoint(station3);
        assertTrue(instance.isWillPassBy(station1, station3));
        assertFalse(instance.isWillPassBy(station1, station4));
    }

    @Test
    public void testRemoveBefore() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        Station station3 = new Station();
        Station station4 = new Station();
        station1.initId();
        station2.initId();
        station3.initId();
        station4.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        instance.addMapPoint(station3);
        instance.addMapPoint(station4);
        instance.removeBefore(station2);
        assertEquals(station2, instance.firstMapPoint());
        assertEquals(station4, instance.lastMapPoint());
        assertEquals(3, instance.getMapPoints().size());
    }

    @Test
    public void testRemoveAfter() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        Station station3 = new Station();
        Station station4 = new Station();
        station1.initId();
        station2.initId();
        station3.initId();
        station4.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        instance.addMapPoint(station3);
        instance.addMapPoint(station4);
        instance.removeAfter(station2);
        assertEquals(station1, instance.firstMapPoint());
        assertEquals(station2, instance.lastMapPoint());
        assertEquals(2, instance.getMapPoints().size());
    }

    @Test
    public void testFirstMapPoint() {
        instance = new TransportationLineImpl();
        Station station1 = new Station();
        Station station2 = new Station();
        station1.initId();
        station2.initId();
        instance.addMapPoint(station1);
        instance.addMapPoint(station2);
        assertEquals(instance.firstMapPoint(), station1);
    }

    @Test
    public void testAddMapPoint() {
        System.out.println("addMapPoint");
        MapPoint mapPoint = new MapPoint();
        instance = new TransportationLineImpl();
        instance.addMapPoint(mapPoint);
        assertEquals(1, instance.getMapPoints().size());
    }

    @Test
    public void testEquals() {
    }

    /*
     get, set, hashcode and toString
     */
    @Test
    public void testGetId() {
    }

    @Test
    public void testSetId() {
    }

    @Test
    public void testGetName() {
    }

    @Test
    public void testSetName() {
    }

    @Test
    public void testGetMapPoints() {
    }

    @Test
    public void testSetMapPoints() {
    }

    @Test
    public void testHashCode() {
    }

    @Test
    public void testToString() {
    }

    /*
     impl
     */
    @Test
    public void testClone() {
    }

    public class TransportationLineImpl extends TransportationLine {

        @Override
        public TransportationLine clone() {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }
    }

}
