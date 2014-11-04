/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.BusLine;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;
import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;
import org.junit.Ignore;

/**
 *
 * @author youssef
 */
public class TransportationResponseTest {

    @Test
    public void testAddTransportationPath() {
        System.out.println("addTransportationPath");
        TransportationPath transportationPath = new TransportationPath();
        TransportationResponse instance = new TransportationResponse();
        instance.addTransportationPath(transportationPath);
        assertEquals(1, instance.getTransportationPaths().size());
    }

    @Test
    public void testAddTransportationPaths() {
        System.out.println("addTransportationPaths");
        TransportationResponse instance = new TransportationResponse();
        List<TransportationPath> transportationPaths = new ArrayList<>();
        transportationPaths.add(new TransportationPath());
        transportationPaths.add(new TransportationPath());
        instance.addTransportationPaths(transportationPaths);
        assertEquals(2, instance.getTransportationPaths().size());
    }

    @Test
    public void testIsHave() {
        System.out.println("isHave");
        TransportationLine transportationLine1 = new BusLine();
        TransportationLine transportationLine2 = new BusLine();
        transportationLine1.initId();
        transportationLine2.initId();
        TransportationPath transportationPath1 = new TransportationPath();
        TransportationPath transportationPath2 = new TransportationPath();
        transportationPath2.addTransportationLine(transportationLine1);
        TransportationResponse instance = new TransportationResponse();
        instance.addTransportationPath(transportationPath1);
        instance.addTransportationPath(transportationPath2);
        assertThat(instance.isHave(transportationLine1),is(true));
        assertThat(instance.isHave(transportationLine2),is(false));
        transportationPath2.addTransportationLine(transportationLine2);
        assertThat(instance.isHave(transportationLine2),is(true));
    }

    @Test
    //TODO add && enable test
    @Ignore
    public void testCreate() {
        System.out.println("create");
        TransportationRequest transportationRequest = null;
        List<TransportationLine> transportationLinesD = null;
        List<Station> stations = null;
        TransportationResponse expResult = null;
        TransportationResponse result = TransportationResponse.create(transportationRequest, transportationLinesD, stations);
        assertEquals(expResult, result);
        fail("The test case is a prototype.");
    }

    /*
     get, set, hashcode and toString
     */
    @Test
    public void testGetTransportationPaths() {
    }

    @Test
    public void testSetTransportationPaths() {
    }

    @Test
    public void testToString() {
    }

}
