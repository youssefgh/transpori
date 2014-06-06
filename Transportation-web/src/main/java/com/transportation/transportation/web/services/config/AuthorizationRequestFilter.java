/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services.config;

import com.transportation.transportation.ejb.service.ServiceUser;
import com.transportation.transportation.ejb.service.impl.ServiceUserImpl;
import java.io.IOException;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.NameBinding;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

/**
 *
 * @author youssef
 */
@Provider
@RequestScoped
public class AuthorizationRequestFilter implements ContainerRequestFilter {

    //TODO remove explicite instanciation
    @EJB
    private ServiceUser service = new ServiceUserImpl();

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        System.out.println("auth : " + requestContext.getHeaders().getFirst("authorization"));
        
        
        if (!service.isAuthorized(requestContext.getHeaders().getFirst("authorization"))) {
            requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).entity("User cannot access the resource.").build());
        }
    }

}


//@NameBinding
//@Retention(RetentionPolicy.RUNTIME)
//public @interface CheckAuthorization {}
