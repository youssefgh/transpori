/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.model.entites.TransportationLine;
import com.transportation.transportation.model.dtos.TransportationPath;
import com.transportation.transportation.model.dtos.TransportationRequest;
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
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("TransportationPath")
@RequestScoped
public class TransportationPathResource {

    @Context
    private UriInfo context;

    @EJB
    private DaoTransportationLine dao;

    @POST
    @Consumes(value = MediaType.APPLICATION_JSON)
    @Produces(value = MediaType.APPLICATION_JSON)
    public TransportationPath getJson(TransportationRequest transportationRequest) {
        List<TransportationLine> transportationLines = dao.readAll();
        for (int i = 0; i < transportationLines.size(); i++) {
            TransportationLine transportationLine = transportationLines.get(i);/*
            if(!transportationLine.isWillPassBy(transportationRequest.getDestination())){
                transportationLines.remove(i);
            }
            */
        }
        return new TransportationPath();
    }
    
}
