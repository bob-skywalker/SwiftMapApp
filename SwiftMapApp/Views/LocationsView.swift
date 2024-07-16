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
            
            Map(position: $vm.mapCameraPosition)
            
            VStack(spacing: 0){
                
                header
                .padding()
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    private var header: some View {
        VStack {
            Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: vm.mapLocation)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.isArrowTapped ? 180 : 0))
                }
                .onTapGesture {
                    vm.toggleLocationsList()
                }
            if vm.isArrowTapped {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}
