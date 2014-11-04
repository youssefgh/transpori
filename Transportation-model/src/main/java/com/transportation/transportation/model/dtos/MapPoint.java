/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.transportation.transportation.model.entities.Station;
import java.io.Serializable;
import java.util.Objects;
import javax.validation.constraints.NotNull;

/**
 *
 * @author youssef
 */
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME)
@JsonSubTypes({
    @JsonSubTypes.Type(Station.class)
})
public class MapPoint implements Serializable {

    private static final long serialVersionUID = 1L;
    @NotNull
    protected Float latitude;
    @NotNull
    protected Float longitude;

    public MapPoint() {
    }

    public MapPoint(Float latitude, Float longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Float getLatitude() {
        return latitude;
    }

    public void setLatitude(Float latitude) {
        this.latitude = latitude;
    }

    public Float getLongitude() {
        return longitude;
    }

    public void setLongitude(Float longitude) {
        this.longitude = longitude;
    }

    /**
     * 
     * @param mapPoint
     * @return Distance in Meter
     */
    public Double distanceTo(MapPoint mapPoint) {
        final Float radius = 6371F;
        Double dLatitude = Math.toRadians(mapPoint.getLatitude() - latitude);
        Double dLongitude = Math.toRadians(mapPoint.getLongitude() - longitude);
        Double latitude1 = Math.toRadians(latitude);
        Double latitude2 = Math.toRadians(mapPoint.getLatitude());
        Double haversine = Math.sin(dLatitude / 2) * Math.sin(dLatitude / 2)
                + Math.sin(dLongitude / 2) * Math.sin(dLongitude / 2)
                * Math.cos(latitude1) * Math.cos(latitude2);
        Double c = 2 * Math.atan2(Math.sqrt(haversine), Math.sqrt(1 - haversine));
        return radius * c * 1000;
    }

    public boolean isNear(MapPoint mapPoint, Double distanceInMeter) {
        return distanceTo(mapPoint) <= distanceInMeter;
    }

    @JsonIgnore
    public boolean isStation() {
        return this instanceof Station;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 97 * hash + Objects.hashCode(this.latitude);
        hash = 97 * hash + Objects.hashCode(this.longitude);
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
        final MapPoint other = (MapPoint) obj;
        if (!Objects.equals(this.latitude, other.latitude)) {
            return false;
        }
        return Objects.equals(this.longitude, other.longitude);
    }
    
    @Override
    public String toString() {
        return "MapPoint{" + "latitude=" + latitude + ", longitude=" + longitude + '}';
    }

}
