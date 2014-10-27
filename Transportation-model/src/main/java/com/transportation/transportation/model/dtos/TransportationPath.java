/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.model.dtos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.transportation.transportation.model.entities.TransportationLine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author youssef
 */
public class TransportationPath implements Serializable {

    private List<TransportationLine> transportationLines;
    
    {
        transportationLines = new ArrayList<>();
    }

    public TransportationPath() {
    }

    public TransportationPath(TransportationPath transportationPath) {
        this.transportationLines = new ArrayList<>(transportationPath.transportationLines);
    }

    public List<TransportationLine> getTransportationLines() {
        return Collections.unmodifiableList(transportationLines);
    }

    public void setTransportationLines(List<TransportationLine> transportationLines) {
        this.transportationLines = transportationLines;
    }
    
    public void addTransportationLine(TransportationLine transportationLine){
        transportationLines.add(transportationLine);
    }

    void addTransportationLineToBegin(TransportationLine transportationLine) {
        transportationLines.add(0, transportationLine);
    }
    
    @JsonIgnore
    TransportationLine firstTransportationLine(){
        return transportationLines.get(0);
    }
    
    @JsonIgnore
    TransportationLine lastTransportationLine(){
        return transportationLines.get(transportationLines.size()-1);
    }
    
    public void clear(){
        transportationLines.clear();
    }
    
    @Override
    public TransportationPath clone(){
        return new TransportationPath(this);
    }
    
}
