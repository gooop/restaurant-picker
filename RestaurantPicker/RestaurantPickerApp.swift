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
    @StateObject private var backendManager = BackendManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(locationManager)
                .environmentObject(backendManager)
        }
        .modelContainer(for: Menu.self)
    }
}

/// Manager class that connects to the back end API.
class BackendManager: ObservableObject {
    var yelpApiKey: String
    
    init() {
        yelpApiKey = ""
        Task {
            do {
                yelpApiKey = try await Common.requestFromBackEndAsync(endpoint: "http://10.4.5.188:8000/api/yelpKey/secret/").yelpApiKey
                print("[\(BackendManager.self)] Success getting a Yelp API key (not a guarantee of validity).")
            } catch APIError.invalidData {
                print("[\(BackendManager.self)] Invalid data in back end response")
            } catch APIError.invalidURL {
                print("[\(BackendManager.self)] Invalid URL in back end call")
            } catch APIError.invalidResponse(let response) {
                print("[\(BackendManager.self)] Invalid response in back end response: \(response)")
            } catch {
                print("[\(BackendManager.self)] Unknown error in back end request")
            }
        }
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
