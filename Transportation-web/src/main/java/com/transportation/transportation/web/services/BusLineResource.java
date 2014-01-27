/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoBusLine;
import com.transportation.transportation.model.entites.BusLine;
import java.util.List;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
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
@Path("BusLine")
@RequestScoped
public class BusLineResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoBusLine dao;

    @GET
    @Path("{id}")
    @Produces(value = MediaType.APPLICATION_JSON)
    public BusLine getJson(@PathParam("id") String id) {
        return dao.read(id);
    }

    @POST
    @Path("{id}")
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(@PathParam("id") String id, BusLine busLine) {
        busLine.setId(id);
        dao.update(busLine);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<BusLine> getJsons() {
        return dao.readAll();
    }

    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void putJson(BusLine busLine) {
        busLine.initId();
        dao.create(busLine);
    }
}
