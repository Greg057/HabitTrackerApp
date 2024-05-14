//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Gregoire Meyer on 07/05/2024.
//

import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var buildHabit = true
    @State private var count = 1
    @State private var icon = "dumbbell"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Enter Habit Name", text: $name)
                }
                
                Section("Details") {
                    Picker("I want to", selection: $buildHabit) {
                        Text("Build a habit").tag(true)
                        Text("Break a habit").tag(false)
                    }
                    
                    Stepper(buildHabit ? "How often per day: \(count)" : "Max limit per day: \(count)", value: $count, in: 1...99)
                    
                    Picker("Icon", selection: $icon) {
                        Image(systemName: "dumbbell").tag("dumbbell")
                        Image(systemName: "laptopcomputer").tag("laptopcomputer")
                        Image(systemName: "book").tag("book")
                        Image(systemName: "figure.walk").tag("figure.walk")
                        Image(systemName: "figure.mind.and.body").tag("figure.mind.and.body")
                        Image(systemName: "book.pages").tag("book.pages")
                    }
                    .pickerStyle(.navigationLink)
                }
                
                
                Button {
                    let newHabit = Habit(name: name, buildHabit: buildHabit, count: count, icon: icon, lastUpdatedDay: Calendar.current.component(.day, from: Date()))
                    modelContext.insert(newHabit)
                    dismiss()
                } label: {
                    Label("Add Habit", systemImage: "plus")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(-10)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .listRowBackground(Color.blue)
            }
            
            .scrollContentBackground(.automatic)
            .navigationTitle("Add new habit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
}
