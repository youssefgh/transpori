/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

/**
 *
 * @author youssef
 */
public class BusLine extends TransportationLine {

    public BusLine() {
    }

    public BusLine(TransportationLine transportationLine) {
        super(transportationLine);
    }

    @Override
    public TransportationLine clone() {
        return new BusLine(this);
    }

}
