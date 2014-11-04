/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.transportation.transportation.model.dtos;

import com.transportation.transportation.model.entities.Station;
import com.transportation.transportation.model.entities.TransportationLine;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author youssef
 */
public class TransportationLines extends ArrayList<TransportationLine> {

    public TransportationLines() {
    }

    public TransportationLines(Collection<? extends TransportationLine> c) {
        super(c);
    }

    public TransportationLines find(MapPoint originPosition, MapPoint destination, List<Station> stations) {
        TransportationLines foundTransportationLines = new TransportationLines();
        Double distance = originPosition.distanceTo(destination);
        Double searchDistance = distance / 4;
        List<Station> originNearbyStations = findNearbyStations(originPosition, searchDistance, stations);
        Station nearestStation;
        List<TransportationLine> passByLines;
        for (Station originNearbyStation : originNearbyStations) {
            passByLines = findPassByLines(originNearbyStation);
            for (TransportationLine transportationLine : passByLines) {
                nearestStation = null;
                for (int i = transportationLine.stations().indexOf(originNearbyStation) + 1; i < transportationLine.stations().size(); i++) {
                    Station station = transportationLine.stations().get(i);
                    if (station.isNear(destination, searchDistance)) {
                        if (nearestStation == null || nearestStation.distanceTo(destination) > station.distanceTo(destination)) {
                            nearestStation = station;
                        }
                    }
                }
                if (nearestStation != null && nearestStation.isNear(destination, searchDistance)) {
                    transportationLine.removeBefore(originNearbyStation);
                    transportationLine.removeAfter(nearestStation);
                    if (!transportationLine.getMapPoints().isEmpty()) {
                        foundTransportationLines.add(transportationLine);
                    }
                }
            }
        }
        foundTransportationLines.keepDistinct();
        return foundTransportationLines;
    }

    public List<Station> findNearbyStations(MapPoint mapPoint, Double distance, List<Station> stations) {
        List<Station> nearbyStations = new ArrayList<>();
        for (Station station : stations) {
            if (station.isNear(mapPoint, distance)) {
                nearbyStations.add(station);
                for (int i = 0; i < nearbyStations.size() - 1; i++) {
                    Station station1 = nearbyStations.get(i);
                    if (station1.distanceTo(mapPoint) > station.distanceTo(mapPoint)) {
                        nearbyStations.add(i, station);
                        nearbyStations.remove(nearbyStations.size() - 1);
                        break;
                    }
                }
            }
        }
        return nearbyStations;
    }

    //TODO refactor && add this combined with keepDistinct() test 
    public List<TransportationLine> findPassByLines(Station station) {
        TransportationLines transportationLines = new TransportationLines();
        for (TransportationLine transportationLine : this) {
            if (transportationLine.isWillPassBy(station)) {
                transportationLines.add(transportationLine.clone());
            }
        }
        transportationLines.keepDistinct();
        return transportationLines;
    }

    void keepDistinct() {
        for (int j = 0; j < size(); j++) {
            TransportationLine transportationLine = get(j);
            while (indexOf(transportationLine) != lastIndexOf(transportationLine)) {
                remove(lastIndexOf(transportationLine));
            }
        }
    }

    List<TransportationPath> toTransportationPaths() {
        List<TransportationPath> transportationPaths = new ArrayList<>();
        TransportationPath transportationPath;
        for (TransportationLine transportationLine : this) {
            transportationPath = new TransportationPath();
            transportationPath.addTransportationLine(transportationLine);
            transportationPaths.add(transportationPath);
        }
        return transportationPaths;
    }

    TransportationLine firstTransportationLine() {
        return get(0);
    }

    TransportationLine lastTransportationLine() {
        return get(size() - 1);
    }

}
