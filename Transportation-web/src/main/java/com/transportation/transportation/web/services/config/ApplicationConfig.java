/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.web.services.config;

import java.util.Set;
import javax.ws.rs.core.Application;
import org.glassfish.jersey.jackson.JacksonFeature;

/**
 *
 * @author youssef
 */
@javax.ws.rs.ApplicationPath("rest")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        resources.add(JacksonFeature.class);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method. It is automatically
     * populated with all resources defined in the project. If required, comment
     * out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(com.transportation.transportation.web.services.BusLineResource.class);
        resources.add(com.transportation.transportation.web.services.DirectionResource.class);
        resources.add(com.transportation.transportation.web.services.StationResource.class);
        resources.add(com.transportation.transportation.web.services.TransportationLineResource.class);
        resources.add(com.transportation.transportation.web.services.TransportationPathResource.class);
        resources.add(com.transportation.transportation.web.services.config.CrossDomainFilter.class);
        resources.add(com.transportation.transportation.web.services.config.ObjectMapperResolver.class);
    }

}
