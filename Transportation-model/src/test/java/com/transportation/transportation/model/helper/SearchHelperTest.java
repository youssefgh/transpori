/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.helper;

import com.transportation.transportation.model.dtos.MapPoint;
import org.junit.Test;
import static org.junit.Assert.*;
import static com.transportation.transportation.model.helper.SearchHelper.*;

/**
 *
 * @author youssef
 */
public class SearchHelperTest {

    @Test
    public void testPlus() {
        final Double avgDistance = new MapPoint(ORIGIN, ORIGIN).distanceTo(new MapPoint(ORIGIN, ORIGIN + 1));
        assertTrue(plus(ORIGIN, avgDistance) == 2F);
    }

}
