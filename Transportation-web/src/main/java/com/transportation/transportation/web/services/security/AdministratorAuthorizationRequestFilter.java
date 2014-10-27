/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services.security;

import com.transportation.transportation.ejb.service.ServiceUser;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;

/**
 *
 * @author youssef
 */
@Provider
@AdministratorAuthorized
public class AdministratorAuthorizationRequestFilter implements ContainerRequestFilter {

    @EJB
    private ServiceUser service;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        LOG.info("Administrator filter");
        if (requestContext.getHeaders().getFirst("authorization") == null || !service.isAuthorizedAdministrator(requestContext.getHeaders().getFirst("authorization"))) {
            requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).entity("User cannot access the resource.").build());
        }
    }
    private static final Logger LOG = Logger.getLogger(AdministratorAuthorizationRequestFilter.class.getName());

}
