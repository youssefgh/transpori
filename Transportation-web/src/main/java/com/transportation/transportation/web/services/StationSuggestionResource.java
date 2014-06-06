/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoStationSuggestion;
import com.transportation.transportation.model.entities.StationSuggestion;
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
@Path("Station/Suggestion")
@RequestScoped
public class StationSuggestionResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoStationSuggestion dao;
    
    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.TEXT_PLAIN)
    public String putJson(StationSuggestion stationSuggestion) {
        stationSuggestion.initId();
        dao.create(stationSuggestion);
        return stationSuggestion.getId();
    }

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(StationSuggestion stationSuggestion) {
        dao.update(stationSuggestion);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<StationSuggestion> getJsons() {
        return dao.readAll();
    }

    @DELETE
    @Path("{id}")
    public void deleteJson(@PathParam("id") String id) {
        dao.delete(new StationSuggestion(id));
    }

}
