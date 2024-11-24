//
//  Common.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 10/21/24.
//

import MapKit
import SwiftUI

struct Common {
    /// Search with Apple Maps
    public static func searchAsync(for query: String, visibleRegion: MKCoordinateRegion? = nil) async -> [MKMapItem] {
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
    
    /// Request from backend API
    public static func requestFromBackEndAsync(endpoint: String) async throws -> BackendData {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        // Attempt to connect to server and get a response
        let (data, response) = try await URLSession.shared.data(from: url)

        // Error handling
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse("No HTTP response")
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse(String(httpResponse.statusCode))
        }
        
        // Decode and return value
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(BackendData.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse(String)
    case invalidData
}
