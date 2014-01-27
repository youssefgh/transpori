/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoMapPoint;
import com.transportation.transportation.model.entites.MapPoint;
import java.io.Serializable;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.Query;

/**
 *
 * @author youssef
 */
@Stateless
public class DaoMapPointImpl extends DaoGenericImpl<MapPoint> implements DaoMapPoint, Serializable {

    public DaoMapPointImpl() {
        super(MapPoint.class);
    }

}
