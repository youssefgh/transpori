/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import org.codehaus.jackson.annotate.JsonSubTypes;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 *
 * @author youssef
 */
@Document(collection = "stationSuggestion")
@JsonSubTypes({
    @JsonSubTypes.Type(BusStationSuggestion.class),
    @JsonSubTypes.Type(TrainStationSuggestion.class),
    @JsonSubTypes.Type(TramwayStationSuggestion.class)
})
public class StationSuggestion extends Station {

    public StationSuggestion() {
    }

    public StationSuggestion(String id) {
        super(id);
    }

}
