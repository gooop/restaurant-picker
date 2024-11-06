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
    @State private var viewSelection: Int = 1 // Default is search view
    
    // Code to prevent preview crashing
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    // View body
    var body: some View {
        TabView(selection: $viewSelection) {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
                .tag(1)
                .environmentObject(locationManager)

            MenuView()
                .tabItem {
                    Label("Menus", systemImage: "book.circle.fill")
                }
                .tag(2)
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
        .modelContainer(for: Menu.self, inMemory: true)
}
