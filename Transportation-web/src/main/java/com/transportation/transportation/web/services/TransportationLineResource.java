/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.service.ServiceTransportationLine;
import com.transportation.transportation.model.entities.TransportationLine;
import com.transportation.transportation.web.services.security.AdministratorAuthorized;
import java.util.List;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("TransportationLine")
@RequestScoped
@AdministratorAuthorized
public class TransportationLineResource {

    @Context
    private UriInfo context;

    @EJB
    private ServiceTransportationLine service;

    @GET
    @Path("{id}")
    @Produces(value = MediaType.APPLICATION_JSON)
    public TransportationLine getJson(@PathParam("id") String id) {
        return service.read(id);
    }

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(TransportationLine transportationLine) {
        service.update(transportationLine);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<TransportationLine> getJsons() {
        return service.readAll();
    }

    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void putJson(TransportationLine transportationLine) {
        service.create(transportationLine);
    }

    @DELETE
    @Path("{id}")
    public void deleteJson(@PathParam("id") String id) {
        service.delete(id);
    }
}
