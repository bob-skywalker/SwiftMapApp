//
//  LocationsVIewModel.swift
//  SwiftMapApp
//
//  Created by Bo Zhong on 7/15/24.
//

import Foundation
import _MapKit_SwiftUI
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updateCameraPosition(location: mapLocation)
        }
    }
    @Published var mapCameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: LocationsDataService.locations.first!.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    @Published private(set) var isArrowTapped: Bool = false

    init() {
        self.locations = LocationsDataService.locations
        self.mapLocation = LocationsDataService.locations.first!
    }
    
    private func updateCameraPosition(location: Location) {
        withAnimation(.easeInOut) {
            mapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            isArrowTapped.toggle()
        }
    }
    
    func displayTappedLocation(location: Location) {
        mapLocation = location
        isArrowTapped.toggle()
    }
}
