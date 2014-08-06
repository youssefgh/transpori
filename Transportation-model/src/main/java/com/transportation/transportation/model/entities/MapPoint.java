/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entities;

import java.io.Serializable;
import javax.validation.constraints.NotNull;
import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonSubTypes;
import org.codehaus.jackson.annotate.JsonTypeInfo;
import org.springframework.data.annotation.Transient;

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
    @Transient
    private final Integer defaultNearbyDistanceInMeter = 5;

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

    public boolean isNear(MapPoint mapPoint) {
        return distanceTo(mapPoint) < defaultNearbyDistanceInMeter;
    }

    public boolean isNear(MapPoint mapPoint, Double distanceInMeter) {
        return distanceTo(mapPoint) < distanceInMeter;
    }

    @JsonIgnore
    public boolean isStation() {
        return this instanceof Station;
    }

    @Override
    public String toString() {
        return "MapPoint{" + "latitude=" + latitude + ", longitude=" + longitude + '}';
    }

}
