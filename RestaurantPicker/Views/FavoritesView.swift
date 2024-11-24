//
//  FavoritesView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 11/22/24.
//

import SwiftUI

struct FavoritesView: View {
    // Setup vars
    @State private var backendData: BackendData?
    
    // View body
    var body: some View {
        VStack {
            Text("Hi!")
            Text("Request test: \(backendData?.yelpApiKey ?? "No data")")
        }
        .task {
            do {
                backendData = try await Common.requestFromBackEndAsync(endpoint: "http://10.4.5.188:8000/api/yelpKey/secret/")
            } catch APIError.invalidData {
                print("Invalid data in back end response")
            } catch APIError.invalidURL {
                print("Invalid URL in back end call")
            } catch APIError.invalidResponse(let response) {
                print("Invalid response in back end response: \(response)")
            } catch {
                print("Unknown error in back end request")
            }
        }
    }
}


