//
//  EditMenuView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 9/29/24.
//

import SwiftUI
import SwiftData

struct EditMenuView: View {
    @Bindable var menu: Menu
    
    var body: some View {
        Form {
            TextField("Name", text: $menu.label)
            
            Section("Restaurants") {
                
                List (menu.places, id: \.self) { place in
                        Text(place.name ?? "Unknown Place")
                }
            }
            
            Button{
                
            }
            label: {
                Text("Add Restaurant")
            }
        }
        .navigationTitle("Edit Menu")
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Menu.self, configurations: config)
        let example = Menu(label: "example")
        return EditMenuView(menu: example)
            .modelContainer(container)
    } catch {
        fatalError("Could not create ModelContainer in preview: \(error)")
    }
}
