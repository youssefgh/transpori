/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.BusLine;
import com.transportation.transportation.model.entities.TransportationLine;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author youssef
 */
public class TransportationPathTest {

    @Test
    public void testAddTransportationLine() {
        System.out.println("addTransportationLine");
        TransportationLine transportationLine = new BusLine();
        TransportationPath instance = new TransportationPath();
        instance.addTransportationLine(transportationLine);
        assertEquals(1, instance.getTransportationLines().size());
    }

    @Test
    public void testAddTransportationLineToBegin() {
        System.out.println("addTransportationLineToBegin");
        TransportationPath instance = new TransportationPath();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        TransportationLine expResult = transportationLine2;
        instance.addTransportationLine(transportationLine1);
        instance.addTransportationLineToBegin(transportationLine2);
        TransportationLine result = instance.getTransportationLines().get(0);
        assertEquals(expResult, result);
    }

    @Test
    public void testFirstTransportationLine() {
        System.out.println("firstTransportationLine");
        TransportationPath instance = new TransportationPath();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        TransportationLine expResult = transportationLine1;
        instance.addTransportationLine(transportationLine1);
        instance.addTransportationLine(transportationLine2);
        TransportationLine result = instance.firstTransportationLine();
        assertEquals(expResult, result);
    }

    @Test
    public void testLastTransportationLine() {
        System.out.println("lastTransportationLine");
        TransportationPath instance = new TransportationPath();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        TransportationLine expResult = transportationLine2;
        instance.addTransportationLine(transportationLine1);
        instance.addTransportationLine(transportationLine2);
        TransportationLine result = instance.lastTransportationLine();
        assertEquals(expResult, result);
    }

    @Test
    public void testClear() {
        System.out.println("clear");
        TransportationPath instance = new TransportationPath();
        TransportationLine transportationLine1 = new BusLine();
        transportationLine1.initId();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine2.initId();
        instance.addTransportationLine(transportationLine1);
        instance.addTransportationLine(transportationLine2);
        instance.clear();
        assertTrue(instance.getTransportationLines().isEmpty());
    }

    @Test
    public void testClone() {
        System.out.println("clone");
        TransportationPath instance = new TransportationPath();
        instance.addTransportationLine(new BusLine());
        TransportationPath result = instance.clone();
        assertEquals(1, result.getTransportationLines().size());
    }

    /*
     get, set, hashcode and toString
     */
    @Test
    public void testGetTransportationLines() {
    }

    @Test
    public void testSetTransportationLines() {
    }

}
