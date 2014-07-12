/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.MapPoint;
import com.transportation.transportation.model.entities.TransportationLine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.codehaus.jackson.annotate.JsonIgnore;

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
        return transportationLines;
    }

    public void setTransportationLines(List<TransportationLine> transportationLines) {
        this.transportationLines = transportationLines;
    }
    
    public void addTransportationLine(TransportationLine transportationLine){
        transportationLines.add(transportationLine);
    }
    
    @JsonIgnore
    public MapPoint getLastMapPoint(){
        TransportationLine lastTransportationLine = transportationLines.get(transportationLines.size()-1);
        return lastTransportationLine.getLastMapPoint();
    }
    
    public void clear(){
        transportationLines.clear();
    }
}
