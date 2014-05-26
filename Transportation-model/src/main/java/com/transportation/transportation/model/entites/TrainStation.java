/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.entites;

import org.codehaus.jackson.annotate.JsonSubTypes;

/**
 *
 * @author youssef
 */
@JsonSubTypes({
    @JsonSubTypes.Type(TrainStation.class)
})
public class TrainStation extends Station {

}
