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
    @Environment(\.modelContext) private var modelContext
    @State private var searchResults: [MKMapItem] = []

    var body: some View {
        Map {
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                RestaurantSearchButton(searchResults: $searchResults)
                    .padding(.top)
                Spacer()
            }
            .background(.thinMaterial)
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
