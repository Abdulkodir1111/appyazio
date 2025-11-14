//
//  ContentView.swift
//  YazioApp.swift
//
//  Created by Abdulkodir Juraev on 11/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CaloriesView()
                .tabItem {
                    Label("Calories", systemImage: "flame.fill")
                }

            WaterView()
                .tabItem {
                    Label("Water", systemImage: "drop.fill")
                }

            StepsView()
                .tabItem {
                    Label("Steps", systemImage: "figure.walk")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
