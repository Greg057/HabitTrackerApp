//
//  ContentView.swift
//  HabitTracker
//
//  Created by Gregoire Meyer on 07/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            MainPage()
                .tabItem { Label("Home", systemImage: "list.bullet.circle") }
            
            SettingsPage()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    ContentView()
}
