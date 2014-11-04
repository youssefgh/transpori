/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service;

import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.List;

/**
 *
 * @author youssef
 */
public interface ServiceTransportationLine {

    String create(TransportationLine transportationLine);

    TransportationLine read(Object id);

    void update(TransportationLine transportationLine);

    void updateAllStations(Station station);

    void delete(String id);

    List<TransportationLine> readAll();
}
