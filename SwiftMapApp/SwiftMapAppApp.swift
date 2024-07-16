//
//  SwiftMapAppApp.swift
//  SwiftMapApp
//
//  Created by Bo Zhong on 7/15/24.
//

import SwiftUI

@main
struct SwiftMapAppApp: App {
    @StateObject private var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
