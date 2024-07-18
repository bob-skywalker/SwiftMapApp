//
//  LocationsView.swift
//  SwiftMapApp
//
//  Created by Bo Zhong on 7/15/24.
//

import SwiftUI
import MapKit

struct LocationPreviewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.3), radius: 10)
            .padding()
            .transition(.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading))
            )
    }
}

extension View {
    func locationPreviewModifier() -> some View {
        modifier(LocationPreviewModifier())
    }
}

struct LocationsView: View {
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                mapLayer
                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    
                    header
                        .padding()
                    
                    
                    Spacer()
                    
                    
                    cardPreview
                    
                }
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
    
    private var mapLayer: some View {
        Map(position: $vm.mapCameraPosition)  {
            ForEach(vm.locations) {location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1.2 : 0.5)
                        .shadow(radius: 8)
                        .onTapGesture {
                            vm.displayTappedLocationOnPin(location: location)
                        }
                }
            }
        }
        .tint(.blue)
    }
    
    private var cardPreview: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreview(location: location)
                        .locationPreviewModifier()
                }
            }
            
        }
        .animation(.easeInOut, value: vm.mapLocation)
    }
}
