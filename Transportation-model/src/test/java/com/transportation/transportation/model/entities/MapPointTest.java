/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import com.transportation.transportation.model.dtos.MapPoint;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author youssef
 */
public class MapPointTest {
    
    public MapPointTest() {
    }

    @Test
    public void testDistanceTo() {
        System.out.println("distanceTo");
        MapPoint mapPoint = new MapPoint(2F,2F);
        MapPoint instance = new MapPoint(1F,1F);
        Double expResult = 157225.43203807288D;
        Double result = instance.distanceTo(mapPoint);
        assertEquals(expResult, result);
    }

    @Test
    public void testIsNear_MapPoint_Double() {
        System.out.println("isNear");
        MapPoint mapPoint = new MapPoint(3F,3F);
        Double distanceInMeter = 157225.43203807288D;
        MapPoint instance = new MapPoint(1F,1F);
        boolean result = instance.isNear(mapPoint, distanceInMeter);
        assertFalse(result);
        mapPoint = new MapPoint(2F,2F);
        result = instance.isNear(mapPoint, distanceInMeter);
        assertTrue(result);
    }

    @Test
    public void testIsStation() {
        System.out.println("isStation");
        MapPoint instance = new MapPoint();
        boolean result = instance.isStation();
        assertFalse(result);
        instance = new Station();
        result = instance.isStation();
        assertTrue(result);
    }
    
    @Test
    public void testEquals() {
        System.out.println("equals");
        Object obj = new MapPoint();
        MapPoint instance = new MapPoint(1F,1F);
        boolean result = instance.equals(obj);
        assertFalse(result);
        obj = new MapPoint(1F,1F);
        result = instance.equals(obj);
        assertTrue(result);
    }

    /*
     get, set, hashcode and toString
     */
    @Test
    public void testGetLatitude() {
    }

    @Test
    public void testSetLatitude() {
    }

    @Test
    public void testGetLongitude() {
    }

    @Test
    public void testSetLongitude() {
    }

    @Test
    public void testHashCode() {
    }

    @Test
    public void testToString() {
    }
    
}
