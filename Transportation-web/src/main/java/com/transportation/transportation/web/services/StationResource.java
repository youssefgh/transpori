/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.dao.impl.DaoStationImpl;
import com.transportation.transportation.model.entites.BusStation;
import com.transportation.transportation.model.entites.Station;
import com.transportation.transportation.model.entites.TrainStation;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
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
@Path("Station")
@RequestScoped
public class StationResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoStation dao;

    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void putJson(Station station) {
        //station.initId();
        dao.create(station);
    }
    
    @POST
    //@Path("{id}")
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(Station station) {
        dao.update(station);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<Station> getJsons() {
        return dao.readAll();
    }
    
    @DELETE
    //@Consumes(value = MediaType.APPLICATION_JSON)
    
    @Path("{id}")
    public void deleteJson(@PathParam("id") String id){
        
        dao.delete(new Station(id));
        System.out.println("d "+id);
    }

}
