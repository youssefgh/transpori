/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service;

import com.transportation.transportation.model.entities.Station;
import java.util.List;

/**
 *
 * @author youssef
 */
public interface ServiceStation {

    String create(Station station);

    //Station read(Object id);

    void update(Station station);

    void delete(String id);

    List<Station> readAll();
}
