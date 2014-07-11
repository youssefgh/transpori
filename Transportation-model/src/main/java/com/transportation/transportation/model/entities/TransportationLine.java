/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.bson.types.ObjectId;
import org.codehaus.jackson.annotate.JsonIgnore;
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

    @JsonIgnore
    public List<Station> getStations() {
        List<Station> stations = new ArrayList<>();
        for (MapPoint mapPoint : mapPoints) {
            if (mapPoint.isStation()) {
                stations.add((Station) mapPoint);
            }
        }
        return stations;
    }
    
    @JsonIgnore
    public MapPoint getFirstMapPoint() {
        return mapPoints.get(0);
    }
    
    @JsonIgnore
    public MapPoint getLastMapPoint(){
        return mapPoints.get(mapPoints.size()-1);
    }

    public void setMapPoints(List<MapPoint> mapPoints) {
        this.mapPoints = mapPoints;
    }

    public Boolean isLastStation(Station station) {
        return !mapPoints.isEmpty() && mapPoints.get(mapPoints.size() - 1).equals(station);
    }

    public Boolean isWillPassBy(Station station) {
        return mapPoints.contains(station);
    }

    public Boolean isWillPassBy(Station baseStation, Station desiredStation) {
        if (mapPoints.contains(baseStation) && mapPoints.contains(desiredStation)) {
            if (mapPoints.indexOf(baseStation) < mapPoints.indexOf(desiredStation)) {
                return true;
            }
        }
        return false;
    }
    
    public Boolean isExistIn(List<TransportationLine> transportationLines) {
        for (TransportationLine transportationLine : transportationLines) {
            if (transportationLine.equals(this) && this.getLastMapPoint().equals(transportationLine.getLastMapPoint()) 
                    /*&& this.getFirstMapPoint().equals(transportationLine.getFirstMapPoint())*/) {
                return true;
            }
        }
        return false;
    }

    public void removeBefore(Station station) {
        mapPoints = mapPoints.subList(mapPoints.indexOf(station), mapPoints.size());
    }

    public void removeAfter(Station station) {
        mapPoints = mapPoints.subList(0, mapPoints.indexOf(station)+1);
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 59 * hash + Objects.hashCode(this.id);
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
        final TransportationLine other = (TransportationLine) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }
    
    @Override
    public String toString() {
        return "com.transportation.transportation.model.entites.TransportationLine[ id=" + id + " ]";
    }

}
