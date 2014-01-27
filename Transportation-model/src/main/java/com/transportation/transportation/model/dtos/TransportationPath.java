/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entites.TransportationLine;
import java.io.Serializable;
import java.util.ArrayList;
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
    
    public void addTransportationLine(TransportationLine transportationLine){
        transportationLines.add(transportationLine);
    }
    
    public void clear(){
        transportationLines.clear();
    }
}
