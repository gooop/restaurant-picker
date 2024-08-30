//
//  RestaurantSearchButton.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 8/29/24.
//

import SwiftUI
import MapKit

struct RestaurantSearchButton: View {

    var body: some View {
        HStack {
            Button {
                search(for: "restaurant")
            } label: {
                Label("Restaurants", systemImage: "fork.knife.circle.fill")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
    }

    @Binding var searchResults: [MKMapItem]
    
    var mycenter = CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)

    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .defaultLoc,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
            
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
        
}
