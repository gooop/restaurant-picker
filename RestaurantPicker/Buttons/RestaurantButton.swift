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
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                //.frame(minWidth: 30.0, maxWidth: 40.0, minHeight: 30.0, maxHeight: 40.0)
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
