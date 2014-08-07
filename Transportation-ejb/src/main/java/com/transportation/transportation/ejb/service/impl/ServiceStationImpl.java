/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.ejb.service.ServiceStation;
import com.transportation.transportation.ejb.service.ServiceTransportationLine;
import com.transportation.transportation.model.entities.Station;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class ServiceStationImpl implements ServiceStation {

    @EJB
    private DaoStation dao;
    
    @EJB
    private ServiceTransportationLine serviceTransportationLine;

    @Override
    public String create(Station station) {
        station.initId();
        dao.create(station);
        return station.getId();
    }

    @Override
    public void update(Station station) {
        serviceTransportationLine.updateAllStations(station);
        dao.update(station);
    }

    @Override
    public void delete(String id) {
        dao.delete(new Station(id));
    }

    @Override
    public List<Station> readAll() {
        return dao.readAll();
    }
}
