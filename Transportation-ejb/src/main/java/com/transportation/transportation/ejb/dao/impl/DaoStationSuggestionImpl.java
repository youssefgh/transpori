/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.dao.impl;

import com.transportation.transportation.ejb.dao.DaoStationSuggestion;
import com.transportation.transportation.model.entites.StationSuggestion;
import java.io.Serializable;
import javax.ejb.Stateless;

/**
 *
 * @author youssef
 */
@Stateless
public class DaoStationSuggestionImpl extends DaoGenericImpl<StationSuggestion> implements DaoStationSuggestion, Serializable {

    public DaoStationSuggestionImpl() {
        super(StationSuggestion.class);
    }

}
