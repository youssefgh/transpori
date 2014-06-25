/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.model.entities.MapPoint;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import com.transportation.transportation.web.services.security.AdministratorAuthorized;
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
@Path("TransportationLine")
@RequestScoped
@AdministratorAuthorized
public class TransportationLineResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoTransportationLine dao;
    @EJB
    private DaoStation daoStation;

    @GET
    @Path("{id}")
    @Produces(value = MediaType.APPLICATION_JSON)
    public TransportationLine getJson(@PathParam("id") String id) {
        return dao.read(id);
    }

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(TransportationLine transportationLine) {
        List<Station> stations = daoStation.readAll();
        //TODO implement in client side
        for (int i = 0 ; i<transportationLine.getMapPoints().size() ; i++) {
            MapPoint mapPoint = transportationLine.getMapPoints().get(i);
            for (Station station : stations) {
                if(mapPoint.isNear(station)){
                    transportationLine.getMapPoints().set(i, station);
                }
            }
        }
        dao.update(transportationLine);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<TransportationLine> getJsons() {
        List<TransportationLine> transportationLines = dao.readAll();
        return transportationLines;
    }

    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void putJson(TransportationLine transportationLine) {
        List<Station> stations = daoStation.readAll();
        //TODO implement in client side
        for (int i = 0 ; i<transportationLine.getMapPoints().size() ; i++) {
            MapPoint mapPoint = transportationLine.getMapPoints().get(i);
            for (Station station : stations) {
                if(mapPoint.isNear(station)){
                    transportationLine.getMapPoints().set(i, station);
                }
            }
        }
        dao.create(transportationLine);
    }
}
