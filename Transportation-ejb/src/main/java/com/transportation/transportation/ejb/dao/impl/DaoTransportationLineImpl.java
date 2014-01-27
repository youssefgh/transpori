/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoTransportationLine;
import com.transportation.transportation.model.entites.TransportationLine;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class DaoTransportationLineImpl extends DaoGenericImpl<TransportationLine> implements DaoTransportationLine, Serializable {

    public DaoTransportationLineImpl() {
        super(TransportationLine.class);
    }
    
}
