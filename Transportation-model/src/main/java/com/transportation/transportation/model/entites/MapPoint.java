/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entites;

import java.io.Serializable;
import org.bson.types.ObjectId;
import org.codehaus.jackson.annotate.JsonTypeInfo;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 *
 * @author youssef
 */
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME)
public class MapPoint implements Serializable {

    private static final long serialVersionUID = 1L;
    private Float latitude;
    private Float longitude;

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

    public boolean isNearStation(Station station) {
        final Float radius = 6371F;
        Double dLatitude = Math.toRadians(station.getLatitude()-latitude);
        Double dLongitude = Math.toRadians(station.getLongitude()-longitude);
        Double latitude1 = Math.toRadians(latitude);
        Double latitude2 = Math.toRadians(station.getLatitude());
        Double haversine = Math.sin(dLatitude/2) * Math.sin(dLatitude/2) + 
                Math.sin(dLongitude/2) * Math.sin(dLongitude/2) 
                * Math.cos(latitude1) * Math.cos(latitude2);
        Double c = 2 * Math.atan2(Math.sqrt(haversine), Math.sqrt(1-haversine));
        Double distance = radius * c;
        return distance<0.005;
    }

    @Override
    public String toString() {
        return "MapPoint{" + "latitude=" + latitude + ", longitude=" + longitude + '}';
    }

}
