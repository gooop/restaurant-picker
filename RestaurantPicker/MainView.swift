//
//  ContentView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 6/16/24.
//

import SwiftUI
import MapKit
import SwiftData

extension CLLocationCoordinate2D {
    static let defaultLoc = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
}

struct MainView: View {
    // Setup vars
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.modelContext) private var modelContext
    // Code to prevent preview crashing
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    // View body
    var body: some View {
        TabView() {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "book.circle.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }

        }

    }
    
    /// Helper for requesting location permission
    private func checkAndRequestLocationPermission() {
            guard let status = locationManager.authorizationStatus else {
                locationManager.requestLocationPermission()
                return
            }
            
            switch status {
            case .notDetermined:
                locationManager.requestLocationPermission()
            case .restricted, .denied:
                () // do nothing
            case .authorizedWhenInUse, .authorizedAlways:
                () // do nothing
            @unknown default:
                locationManager.requestLocationPermission()
            }
        }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
