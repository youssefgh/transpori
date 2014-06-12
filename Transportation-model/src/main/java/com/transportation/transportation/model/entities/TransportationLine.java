/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.bson.types.ObjectId;
import org.codehaus.jackson.annotate.JsonSubTypes;
import org.codehaus.jackson.annotate.JsonTypeInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 *
 * @author youssef
 */
@Document(collection = "transportationLine")
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME)
@JsonSubTypes({
    @JsonSubTypes.Type(BusLine.class),
    @JsonSubTypes.Type(TrainLine.class),
    @JsonSubTypes.Type(TramwayLine.class)    
})
public class TransportationLine implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    private String id;
    @NotNull
    @Size(min = 2)
    private String name;
    private List<MapPoint> mapPoints;

    {
        mapPoints = new ArrayList<>();
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<MapPoint> getMapPoints() {
        return mapPoints;
    }

    public void setMapPoints(List<MapPoint> mapPoints) {
        this.mapPoints = mapPoints;
    }

    public Boolean isWillPassBy(Station baseStation, Station desiredStation) {
        if(mapPoints.contains(baseStation) && mapPoints.contains(desiredStation)){
            if(mapPoints.indexOf(baseStation)<mapPoints.indexOf(desiredStation))
                return true;
        }
        return false;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TransportationLine)) {
            return false;
        }
        TransportationLine other = (TransportationLine) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.transportation.transportation.model.entites.TransportationLine[ id=" + id + " ]";
    }

}
