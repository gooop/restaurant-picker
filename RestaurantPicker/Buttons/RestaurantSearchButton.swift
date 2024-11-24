//
//  RestaurantSearchButton.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 8/29/24.
//

import SwiftUI
import MapKit

struct RestaurantSearchButton: View {
    @EnvironmentObject var locationManager: LocationManager
    
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?

    var body: some View {
        HStack {
            Button {
                //TODO: Wait for user to give or deny permission, and zoom in if give
                locationManager.requestLocationPermission()
                Task {
                    await searchResults = Common.searchAsync(for: "restaurant", visibleRegion: visibleRegion)
                }
            } label: {
                Label{
                    Text("Search")
                        .font(.title2)
                        .fontWeight(.bold)
                } icon: {
                    Image(systemName: "fork.knife.circle.fill")
                        .resizable()
                        .frame(minWidth: 30.0, idealWidth: 35.0, maxWidth: 40.0, minHeight: 30.0, idealHeight: 35.0, maxHeight: 40.0)
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        
    }


    
    var mycenter = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
        
}
