/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.web.services;

import com.transportation.transportation.model.entites.MapPoint;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.PathParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("directions")
public class DirectionResource {

    @Context
    private UriInfo context;

    /**
     * Retrieves representation of an instance of com.transportation.transportation.web.services.DirectionService
     * @return an instance of com.transportation.transportation.model.entites.MapPoint
     */
    @GET
    @Produces("application/json")
    public MapPoint getJson() {
        return new MapPoint(Float.NaN, Float.NaN);
    }

    /**
     * PUT method for updating or creating an instance of DirectionService
     * @param content representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
    @PUT
    @Consumes("application/json")
    public void putJson(MapPoint content) {
    }
}
