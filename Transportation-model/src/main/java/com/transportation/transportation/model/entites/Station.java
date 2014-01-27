/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entites;

import java.io.Serializable;
import org.bson.types.ObjectId;
import org.codehaus.jackson.annotate.JsonSubTypes;
import org.codehaus.jackson.annotate.JsonTypeInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 *
 * @author youssef
 */
@Document(collection = "station")
//@JsonTypeInfo(use = JsonTypeInfo.Id.NAME,defaultImpl = Station.class)
@JsonSubTypes({
    @JsonSubTypes.Type(BusStation.class),
    @JsonSubTypes.Type(TrainStation.class),
    @JsonSubTypes.Type(TramwayStation.class)    
})
public class Station extends MapPoint implements Serializable {
    
    @Id
    private String id;

    public Station() {
    }

    public Station(String id) {
        this.id = id;
    }
    
    public Station(Float latitude, Float longitude) {
        super(latitude, longitude);
    }

    public void initId() {
        setId(new ObjectId().toString());
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
