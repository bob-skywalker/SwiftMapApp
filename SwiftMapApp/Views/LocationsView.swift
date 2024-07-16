//
//  LocationsView.swift
//  SwiftMapApp
//
//  Created by Bo Zhong on 7/15/24.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    @EnvironmentObject var vm: LocationsViewModel
     
    var body: some View {
        ZStack {
            VStack {
                Button("Change Location") {
                    vm.mapLocation = LocationsDataService.locations[1]
                }
                Map(position: $vm.mapCameraPosition)
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
