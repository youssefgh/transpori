/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.helper;

import com.transportation.transportation.model.dtos.MapPoint;

/**
 *
 * @author youssef
 */
public class SearchHelper {

    public static final Float ORIGIN = 1F;

    public static Float plus(Float origin, Double distance) {
        Double longitudeDistance = new MapPoint(ORIGIN, origin).distanceTo(new MapPoint(ORIGIN, origin + 1));
        Double meterLongitudeDistance = 1 / longitudeDistance;
        Double value = origin + meterLongitudeDistance * distance;
        return value.floatValue();
    }

}
