/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.TransportationLine;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author youssef
 */
public class TransportationResponse implements Serializable {

    private List<TransportationPath> transportationPaths;

    {
        transportationPaths = new ArrayList<>();
    }

    public List<TransportationPath> getTransportationPaths() {
        return transportationPaths;
    }

    public void setTransportationPaths(List<TransportationPath> transportationPaths) {
        this.transportationPaths = transportationPaths;
    }
    
    public void addTransportationPath(TransportationPath transportationPath){
        transportationPaths.add(transportationPath);
    }
    
    public Boolean isHave(TransportationLine transportationLine) {
        for (TransportationPath transportationPath : transportationPaths) {
            if (transportationLine.isExistIn(transportationPath.getTransportationLines())) {
                return true;
            }
        }
        return false;
    }

    @Override
    public String toString() {
        return "TransportationResponse{" + "transportationPaths=" + transportationPaths + '}';
    }

}
