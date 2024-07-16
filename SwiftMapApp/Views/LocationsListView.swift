//
//  LocationsListView.swift
//  SwiftMapApp
//
//  Created by Bo Zhong on 7/16/24.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(0..<vm.locations.count) { idx in
                if vm.mapLocation.name != vm.locations[idx].name {
                    listRowView(idx: idx)
                        .padding(.vertical, 4)
                        .onTapGesture {
                            vm.mapLocation = vm.locations[idx]
                        }
                }
            }
        }
        .listStyle(.plain)
        
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}


extension LocationsListView {
    private func listRowView(idx: Int) -> some View {
        HStack {
            if let imageName = vm.locations[idx].imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading){
                Text(vm.locations[idx].name + ", " + vm.mapLocation.cityName)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(vm.locations[idx].cityName)
                    .font(.subheadline)
            }
        }
        .onTapGesture {
            vm.displayTappedLocation(location: vm.locations[idx])
        }
    }
}
