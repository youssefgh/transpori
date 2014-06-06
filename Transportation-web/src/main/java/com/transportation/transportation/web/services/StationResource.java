/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.dao.DaoStationSuggestion;
import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.model.entities.MapPoint;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
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
public class StationResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoStation dao;
    @EJB
    private DaoStationSuggestion daoSuggestion;
    @EJB
    private DaoTransportationLine daoTransportationLine;

    @PUT
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.TEXT_PLAIN)
    public String putJson(Station station) {
        station.initId();
        dao.create(station);
        return station.getId();
    }

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    public void postJson(Station station) {
        List<TransportationLine> transportationLines = daoTransportationLine.readAll();
        for (int i = 0; i < transportationLines.size(); i++) {
            TransportationLine transportationLine = transportationLines.get(i);
            for (int j = 0; j < transportationLine.getMapPoints().size(); j++) {
                MapPoint mapPoint = transportationLine.getMapPoints().get(j);
                if (mapPoint.equals(station)) {
                    transportationLine.getMapPoints().set(i, station);
                    daoTransportationLine.update(transportationLine);
                    break;
                }
            }
        }
        dao.update(station);
    }

    @GET
    @Produces(value = MediaType.APPLICATION_JSON)
    public List<Station> getJsons() {
        return dao.readAll();
    }

    @DELETE
    @Path("{id}")
    public void deleteJson(@PathParam("id") String id) {
        dao.delete(new Station(id));
    }

}
