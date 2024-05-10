//
//  MainPage.swift
//  HabitTracker
//
//  Created by Gregoire Meyer on 10/05/2024.
//

import SwiftUI
import SwiftData

struct MainPage: View {
    @Environment(\.modelContext) var modelContext
    @Query var habits: [Habit]
    
    @State private var showingAddHabitSheet = false
    
    var dailyProgress: Double {
        var completedCount = 0.0
        
        if habits.isEmpty {
            return 0
        }
        
        for habit in habits {
            if habit.isCompleted {
                completedCount += 1
            }
        }
        return completedCount / Double(habits.count)
    }
    
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
                    
                    Text(String(format: "%.0f%%", round(dailyProgress * 100)))
                        .font(.largeTitle.bold())
                }
                
                Spacer()
                    .frame(height: 30)
                                
                List {
                    ForEach(habits) { habit in
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.blue.opacity(0.4))
                                    .frame(width: 40)
                                
                                Image(systemName: habit.icon)
                            }
                            .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .font(.title3.bold())
                                
                                Text("Goal: \(habit.count) ")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    habit.isCompleted.toggle()
                                }
                            } label: {
                                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .font(.title.bold())
                            }
                        }
                        .opacity(habit.isCompleted ? 0.5 : 1)
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            let habit = habits[index]
                            modelContext.delete(habit)
                        }
                    })
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Habit.self, configurations: config)

    let habit = Habit(name: "Workout", buildHabit: true, count: 1, icon: "dumbbell")
    container.mainContext.insert(habit)

    return MainPage()
        .modelContainer(container)
}
