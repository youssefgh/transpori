/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service.impl;

import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.ejb.service.ServiceTransportationLine;
import com.transportation.transportation.model.entities.MapPoint;
import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class ServiceTransportationLineImpl implements ServiceTransportationLine {

    @EJB
    private DaoTransportationLine dao;

    @Override
    public void create(TransportationLine transportationLine) {
        dao.create(transportationLine);
    }

    @Override
    public TransportationLine read(Object id) {
        return dao.read(id);
    }

    @Override
    public void update(TransportationLine transportationLine) {
        dao.update(transportationLine);
    }

    @Override
    public void delete(String id) {
        TransportationLine transportationLine = new TransportationLine() {

            @Override
            public TransportationLine clone() {
                throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
            }
        };
        transportationLine.setId(id);
        dao.delete(transportationLine);
    }

    @Override
    public List<TransportationLine> readAll() {
        return dao.readAll();
    }

    @Override
    public void updateAllStations(Station station) {
        List<TransportationLine> transportationLines = dao.readAll();
        for (int i = 0; i < transportationLines.size(); i++) {
            TransportationLine transportationLine = transportationLines.get(i);
            for (int j = 0; j < transportationLine.getMapPoints().size(); j++) {
                MapPoint mapPoint = transportationLine.getMapPoints().get(j);
                if (mapPoint.equals(station)) {
                    transportationLine.getMapPoints().set(i, station);
                    dao.update(transportationLine);
                    break;
                }
            }
        }
    }
}