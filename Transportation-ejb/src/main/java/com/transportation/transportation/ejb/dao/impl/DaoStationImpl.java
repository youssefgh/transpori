/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoStation;
import com.transportation.transportation.model.entities.Station;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class DaoStationImpl extends DaoGenericImpl<Station> implements DaoStation, Serializable {

    public DaoStationImpl() {
        super(Station.class);
    }

}
