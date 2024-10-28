//
//  Common.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 10/21/24.
//

import MapKit
import SwiftUI

struct Common {
    public static func search(for query: String, visibleRegion: MKCoordinateRegion? = nil) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: .defaultLoc,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
            
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        return response?.mapItems ?? []
    }
}
