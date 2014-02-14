/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import java.io.Serializable;

/**
 *
 * @author youssef
 */
public class TransportationRequest implements Serializable {

    private OriginPosition originPosition;
    private Destination destination;

    public OriginPosition getOriginPosition() {
        return originPosition;
    }

    public void setOriginPosition(OriginPosition originPosition) {
        this.originPosition = originPosition;
    }

    public Destination getDestination() {
        return destination;
    }

    public void setDestination(Destination destination) {
        this.destination = destination;
    }

    @Override
    public String toString() {
        return "TransportationRequest{" + "originPosition=" + originPosition + ", destination=" + destination + '}';
    }
}
