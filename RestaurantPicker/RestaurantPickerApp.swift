//
//  RestaurantPickerApp.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 6/16/24.
//

import SwiftUI
import SwiftData
import CoreLocation

@main
struct RestaurantPickerApp: App {
    // Location permissions management
    @StateObject private var locationManager = LocationManager()
    


    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(locationManager)
        }
        .modelContainer(for: Menu.self)
    }
}

/// Location manager class for permissions check
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}
