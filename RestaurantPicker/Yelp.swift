//
//  CDYelpFusionKitManager.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 11/20/24.
//


import CDYelpFusionKit
import UIKit

final class Yelp: NSObject {

    static let shared = Yelp()

    var apiClient: CDYelpAPIClient!

    func configure(apiKey: String) {
        self.apiClient = CDYelpAPIClient(apiKey: apiKey)
    }
}
