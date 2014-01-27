/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao;

import com.transportation.transportation.model.entites.BusLine;
import javax.ejb.Remote;


/**
 *
 * @author youssef
 */
@Remote
public interface DaoBusLine extends DaoGeneric<BusLine> {
}
