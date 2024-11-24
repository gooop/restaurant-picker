//
//  AddRestaurantView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 10/21/24.
//
import SwiftUI
import SwiftData
import MapKit

struct AddRestaurantView: View {
    @Bindable var menu: Menu
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // Search properties for adding restaurants to places list
    @State var searchText: String
    @State var selectedRestaurant: MKMapItem?
    @State var searchResults: [MKMapItem]?
    
    var body: some View {
        VStack {
//            Button(action: {
//                menu.clearPlaces()
//            }, label: {
//                Text("DEBUG: Clear places")
//            })
            //TODO: Make search suggestions small overlay on top of map instead of blocking map https://www.youtube.com/watch?v=e0eO1di0cPY
            // Maybe a ZStack??
            //TODO: Make map smaller, and show restaurant details below it.43
            Map(position: $position) {
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), suggestions: {
                    ForEach(searchResults ?? [], id: \.self) { result in
                        Button(action: {
                            searchText = result.name ?? ""
                            selectedRestaurant = result
                            if selectedRestaurant != nil {
                                print("Selected restaurant")
                                menu.addPlace(place: selectedRestaurant!)
                            }
                        }, label: {
                            Label (result.name ?? "Unknown Place", systemImage: "mappin.and.ellipse.circle.fill")
                        })
                    }
            })
        }
        .navigationTitle("New Restaurant")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: searchText) {
            Task {
                await searchResults = Common.searchAsync(for: searchText)
                print("** search results count: \(searchResults?.count ?? 0)")
                for result in searchResults! {
                    let category = result.pointOfInterestCategory ?? nil
                    var categoryString = ""
                    if category == nil {
                        categoryString = "Unknown Category"
                    }
                    else {
                        categoryString = category!.rawValue
                    }
                    print("- result: \(result.name ?? "Unknown Place") \n - - result type: \(categoryString)")
                }
            }
        }
        .onChange(of: selectedRestaurant) {
            position = .camera(.init(centerCoordinate: selectedRestaurant!.placemark.coordinate,
                                     distance: 0))
        }
    }
}
