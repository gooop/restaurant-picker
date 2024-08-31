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
    
    // Map position vars
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var visibleRegion: MKCoordinateRegion?
    
    // Map item vars
    @State private var searchResults: [MKMapItem] = []

    // View body
    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                
                UserAnnotation()
            }
            .mapStyle(.standard(elevation: .realistic))
            .safeAreaInset(edge: .bottom) {
                HStack {
                    Spacer()
                    RestaurantSearchButton(searchResults: $searchResults, visibleRegion: visibleRegion)
                        .padding(.top)
                    Spacer()
                }
                .background(.thinMaterial)
            }
            .onChange(of: searchResults) {
                position = .automatic
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
        }
        .onAppear {
            // Check to prevent preview crashing
            if !isPreview {
                checkAndRequestLocationPermission()
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
