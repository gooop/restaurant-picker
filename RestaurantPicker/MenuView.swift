//
//  MenuView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/12/24.
//

import SwiftUI
import SwiftData
import MapKit

struct MenuView: View {
    // Setup vars
    @Environment(\.modelContext) private var modelContext
    @Query var menus: [Menu]
    @State private var newMenus = [Menu]() // Path for brand new menus
    
    // View body
    var body: some View {
        NavigationStack(path: $newMenus) {
            List {
                ForEach(menus) { menu in
                    NavigationLink(value: menu) {
                        Text(menu.label)
                    }
                }
                .onDelete(perform: deleteMenu)
            }
            .navigationTitle("Menus")
            .navigationDestination(for: Menu.self, destination: EditMenuView.init)
            .toolbar {
                Button("Add Menu", systemImage: "plus", action: addMenu)
            }
        }
    }
    
    /// Add menu helper function
    private func addMenu() {
        let menu = Menu()
        modelContext.insert(menu)
        newMenus = [menu]
    }
    
    /// Delete menu helper function
    private func deleteMenu(_ indexSet: IndexSet) {
        for index in indexSet {
            let menu = menus[index]
            modelContext.delete(menu)
        }
    }
    
}
