/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoBusLine;
import com.transportation.transportation.model.entites.BusLine;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class DaoBusLineImpl extends DaoGenericImpl<BusLine> implements DaoBusLine, Serializable {

    public DaoBusLineImpl() {
        super(BusLine.class);
    }

}
