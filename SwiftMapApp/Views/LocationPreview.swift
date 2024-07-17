//
//  LocationPreview.swift
//  SwiftMapApp
//
//  Created by Bo Zhong on 7/16/24.
//

import SwiftUI

struct LocationPreview: View {
    @EnvironmentObject var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageView
                    .padding(6)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                titleView
            }
            
            VStack {
                learnMoreButton
                
                nextButton
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
                .offset(y: 60)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        
        LocationPreview(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
            .padding()
    }
}

extension LocationPreview {
    private var  imageView: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button(action: {
             
        }, label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125,height: 35)
        })
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button(action: {
            vm.nextButtonLocation()
        }, label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.bordered)
    }
}
