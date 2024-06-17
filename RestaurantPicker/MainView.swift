//
//  ContentView.swift
//  RestaurantPicker
//
//  Created by Gavin Castaneda on 6/16/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        ZStack {
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.black)
                Spacer()
                HStack {
                    Button {
                        //TODO: Do here
                    } label: {
                        Image("Burger")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                    Button {
                        //TODO: Do here
                    } label: {
                        Image("Pizza")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
                Spacer()
            }
        }
    }

    

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
