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
            
            Section("Rating") {
                Picker("Rating", selection: $menu.rating) {
                    Text("⭐").tag(1)
                    Text("⭐⭐").tag(2)
                    Text("⭐⭐⭐").tag(3)
                    Text("⭐⭐⭐⭐").tag(4)
                    Text("⭐⭐⭐⭐⭐").tag(5)
                }
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
        let example = Menu(label: "example", rating: 1)
        return EditMenuView(menu: example)
            .modelContainer(container)
    } catch {
        fatalError("Could not create ModelContainer in preview: \(error)")
    }
}
