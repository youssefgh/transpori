/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.web.services;

import com.transportation.transportation.ejb.service.ServiceUser;
import com.transportation.transportation.model.entities.User;
import com.transportation.transportation.model.exceptions.EmailExistException;
import com.transportation.transportation.model.exceptions.InvalidCredentialsException;
import com.transportation.transportation.model.exceptions.UserExistException;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.PathParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author youssef
 */
@Path("User")
@RequestScoped
public class UserResource {

    @Context
    private UriInfo context;
    
    @EJB
    private ServiceUser service;

    /**
     * Creates a new instance of UserResource
     */
    public UserResource() {
    }
    
    @GET
    @Produces("application/json")
    public User getJson(){
        //For test
        return new User("coucou","doudou");
    }

    /**
     * Retrieves representation of an instance of com.transportation.transportation.web.services.UserResource
     * @param email
     * @param password
     * @param requestContext
     * @return an instance of com.transportation.transportation.model.entities.User
     */
    @GET
    @Path("{email}/{password}")
    @Consumes("application/json")
    @Produces("application/json")
    public Response getJsonByNameAndPassword(@PathParam("email") String email, @PathParam("password") String password, @Context ContainerRequestContext requestContext) {
        System.out.println(email+" "+password);
        try {
            return Response.status(Response.Status.OK).entity(service.signIn(new User(email, password))).build();
        } catch (InvalidCredentialsException ex) {
            return Response.status(Response.Status.UNAUTHORIZED).entity("Invalid credentials.").build();
        }
    }

    /**
     * PUT method for updating or creating an instance of UserResource
     * @param user
     * @return an HTTP response with content of the updated or created resource.
     */
    @PUT
    @Consumes("application/json")
    public Response putJson(User user) {
        try {
            service.subscribe(user);
            return Response.accepted().build();/*
        } catch (EmailExistException ex) {
            return Response.status(Response.Status.CONFLICT).build(); */
        } catch (UserExistException ex) {
            return Response.status(Response.Status.NOT_ACCEPTABLE).build();
        }
    }
}
