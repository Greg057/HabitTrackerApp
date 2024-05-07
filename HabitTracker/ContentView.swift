//
//  ContentView.swift
//  HabitTracker
//
//  Created by Gregoire Meyer on 07/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    
    @State private var showingAddHabitSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(habits) { habit in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .font(.headline)
                                
                                Text("Goal: \(habit.count)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .listRowSpacing(10)
            }
            .navigationTitle("Today")
            .toolbar {
                Button("Add habit", systemImage: "plus") {
                    showingAddHabitSheet.toggle()
                }
            }
            .sheet(isPresented: $showingAddHabitSheet, content: AddHabitView.init)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self)
}
