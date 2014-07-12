/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services.security;

import com.transportation.transportation.ejb.service.ServiceUser;
import com.transportation.transportation.ejb.service.impl.ServiceUserImpl;
import java.io.IOException;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.ManagedBean;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.naming.InitialContext;
import javax.naming.NamingEnumeration;
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
@Stateless
@AdministratorAuthorized
public class AdministratorAuthorizationRequestFilter implements ContainerRequestFilter {

    //TODO remove explicite injection
    //@EJB(lookup = "java:global/Transportation-ear/Transportation-ejb-1.0-SNAPSHOT/ServiceUserImpl")
    private ServiceUser service;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {        
        LOG.info("Administrator filtero");
        try {
            service = InitialContext.doLookup("java:global/Transportation-ear/Transportation-ejb-1.0-SNAPSHOT/ServiceUserImpl");
        } catch (NamingException ex) {
            Logger.getLogger(UserAuthorizationRequestFilter.class.getName()).log(Level.SEVERE, null, ex);
        }System.out.println("a "+requestContext.getHeaders().getFirst("authorization"));
        if (requestContext.getHeaders().getFirst("authorization") == null || !service.isAuthorizedAdministrator(requestContext.getHeaders().getFirst("authorization"))) {
            requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).entity("User cannot access the resource.").build());
        }
    }
    private static final Logger LOG = Logger.getLogger(AdministratorAuthorizationRequestFilter.class.getName());

}