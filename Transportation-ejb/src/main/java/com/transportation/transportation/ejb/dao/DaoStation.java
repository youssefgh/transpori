/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao;

import com.transportation.transportation.model.entites.Station;
import javax.ejb.Remote;


/**
 *
 * @author youssef
 */
@Remote
public interface DaoStation extends DaoGeneric<Station> {
}
