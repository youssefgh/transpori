/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import java.io.Serializable;
import java.util.Objects;
import org.bson.types.ObjectId;
import org.codehaus.jackson.annotate.JsonSubTypes;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 *
 * @author youssef
 */
@Document(collection = "station")
@JsonSubTypes({
    @JsonSubTypes.Type(BusStation.class),
    @JsonSubTypes.Type(TrainStation.class),
    @JsonSubTypes.Type(TramwayStation.class),
    @JsonSubTypes.Type(StationSuggestion.class)
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

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Station other = (Station) obj;
        return Objects.equals(this.id, other.id);
    }
}
