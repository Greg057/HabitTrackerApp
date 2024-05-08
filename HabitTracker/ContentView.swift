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
    
    @State private var dailyProgress = 0.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer()
                    .frame(height: 30)
                
                ZStack {
                    Circle()
                        .stroke(.blue.opacity(0.5), lineWidth: 25)
                        .frame(width: 175)
                    
                    Circle()
                        .trim(from: 0, to: dailyProgress)
                        .stroke(.blue, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                        .frame(width: 175)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut(duration: 0.3), value: dailyProgress)
                    
                    Text(dailyProgress.formatted(.percent))
                        .font(.largeTitle.bold())
                }
                
                Spacer()
                    .frame(height: 30)
                
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
                    .listRowBackground(Color.secondary.opacity(0.1))
                }
                .listRowSpacing(10)
                .scaledToFit()
                .scrollContentBackground(.hidden)
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
