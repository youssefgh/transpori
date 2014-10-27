/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.service.ServiceTransportationResponse;
import com.transportation.transportation.model.dtos.TransportationRequest;
import com.transportation.transportation.model.dtos.TransportationResponse;
import com.transportation.transportation.model.dtos.MapPoint;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("TransportationResponse")
@RequestScoped
public class TransportationResponseResource {

    @Context
    private UriInfo context;

    @EJB
    private ServiceTransportationResponse service;

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.APPLICATION_JSON)
    public TransportationResponse getJson(TransportationRequest transportationRequest) {
        return service.create(transportationRequest);
    }
    
}
