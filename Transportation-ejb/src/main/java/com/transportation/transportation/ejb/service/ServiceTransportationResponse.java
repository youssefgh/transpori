/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.ejb.service;

import com.transportation.transportation.model.dtos.TransportationRequest;
import com.transportation.transportation.model.dtos.TransportationResponse;

/**
 *
 * @author youssef
 */
public interface ServiceTransportationResponse {

    TransportationResponse create(TransportationRequest transportationRequest);
}
