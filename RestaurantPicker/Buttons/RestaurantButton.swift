//
//  RestaurantButton.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/27/24.
//

import SwiftUI
import MapKit

struct RestaurantButton: View {
    var restaurant: MKMapItem
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: {action()}) {
                Text(restaurant.name ?? "Unkown Restaurant")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Text(restaurant.phoneNumber ?? "Unknown Phone Number")
        }
    }
}
