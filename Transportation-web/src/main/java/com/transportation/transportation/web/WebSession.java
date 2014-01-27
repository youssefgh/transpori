/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.web;

import com.transportation.transportation.ejb.dao.DaoBusLine;
import com.transportation.transportation.ejb.dao.DaoMapPoint;
import com.transportation.transportation.ejb.dao.DaoStation;
import java.io.Serializable;
import javax.ejb.EJB;
import javax.enterprise.context.SessionScoped;
import javax.inject.Named;

/**
 *
 * @author youssef
 */
@Named
@SessionScoped
public class WebSession implements Serializable {
    @EJB
    private DaoStation daoStation;
    @EJB
    private DaoMapPoint daoMapPoint;
    @EJB
    private DaoBusLine daoBusLine;
    
    {
        System.out.println("Sessssss");
    }
    
    public String getName(){/*
        BusLine bl = new BusLine();
        bl.getMapPoints().add(new Station(111F, 222F));
        bl.getMapPoints().add(new Station(211F, 223F));
        bl.getMapPoints().add(new Station(311F, 224F));
        daoBusLine.create(bl);
        daoMapPoint.create(new Station(44444F, 22F));
        daoMapPoint.create(new MapPoint(33333F, 1111F));
        System.out.println(daoMapPoint.read("529F8C5E2318D2E7EB024511").getLatitude());
        System.out.println(daoMapPoint.readAll());*/
        return "youssef";
    }
    
}
