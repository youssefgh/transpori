/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entites.MapPoint;
import java.io.Serializable;

/**
 *
 * @author youssef
 */
public class OriginPosition extends MapPoint implements Serializable {

    @Override
    public String toString() {
        return "OriginPosition{" + "latitude=" + latitude + ", longitude=" + longitude + '}';
    }
}
