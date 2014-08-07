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
public class TrainLine extends TransportationLine {

    public TrainLine() {
    }

    public TrainLine(TransportationLine transportationLine) {
        super(transportationLine);
    }

    @Override
    public TransportationLine clone() {
        return new TrainLine(this);
    }

}
