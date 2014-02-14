/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import java.io.Serializable;

/**
 *
 * @author youssef
 */
public class OriginPosition implements Serializable {

    private Float latitude;
    private Float longitude;

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

    @Override
    public String toString() {
        return "OriginPosition{" + "latitude=" + latitude + ", longitude=" + longitude + '}';
    }
}
