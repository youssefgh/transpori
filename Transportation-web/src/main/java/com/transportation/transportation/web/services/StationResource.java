/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.service.ServiceStation;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.web.services.security.AdministratorAuthorized;
import java.util.List;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("Station")
@RequestScoped
@AdministratorAuthorized
public class StationResource {

    @Context
    private UriInfo context;

    @EJB
    private ServiceStation service;

    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.TEXT_PLAIN)
    public String putJson(Station station) {
        return service.create(station);
    }

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(Station station) {
        service.update(station);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<Station> getJsons() {
        return service.readAll();
    }

    //TODO review pathparam vs oop
    @DELETE
    @Path("{id}")
    public void deleteJson(@PathParam("id") String id) {
        service.delete(id);
    }

}
