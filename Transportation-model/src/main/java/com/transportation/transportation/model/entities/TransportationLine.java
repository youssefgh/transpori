/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.transportation.transportation.model.dtos.MapPoint;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.bson.types.ObjectId;
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
public abstract class TransportationLine implements Serializable {

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

    public TransportationLine() {
    }

    public TransportationLine(TransportationLine transportationLine) {
        id = transportationLine.getId();
        name = transportationLine.getName();
        mapPoints.addAll(transportationLine.getMapPoints());
    }

    public void initId() {
        id = new ObjectId().toString();
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
        return Collections.unmodifiableList(mapPoints);
    }

    @JsonIgnore
    public List<Station> stations() {
        List<Station> stations = new ArrayList<>();
        for (MapPoint mapPoint : mapPoints) {
            if (mapPoint.isStation()) {
                stations.add((Station) mapPoint);
            }
        }
        return stations;
    }

    @JsonIgnore
    public MapPoint firstMapPoint() {
        return mapPoints.get(0);
    }

    @JsonIgnore
    public MapPoint lastMapPoint() {
        return mapPoints.get(mapPoints.size() - 1);
    }

    public void setMapPoints(List<MapPoint> mapPoints) {
        this.mapPoints = mapPoints;
    }

    public void addMapPoint(MapPoint mapPoint) {
        mapPoints.add(mapPoint);
    }

    public Boolean update(Station station) {
        Boolean update = false;
        List<Station> stations = stations();
        for (Station stationItem : stations) {
            if (station.equals(stationItem)) {
                mapPoints.set(mapPoints.indexOf(station), station);
                update = true;
            }
        }
        return update;
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

    public void removeBefore(Station station) {
        mapPoints = mapPoints.subList(mapPoints.indexOf(station), mapPoints.size());
    }

    public void removeAfter(Station station) {
        mapPoints = mapPoints.subList(0, mapPoints.indexOf(station) + 1);
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
        return Objects.equals(this.id, other.id);
    }

    @Override
    public String toString() {
        return "com.transportation.transportation.model.entites.TransportationLine[ id=" + id + " ]";
    }

    public abstract TransportationLine clone();

}
