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
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Enter Habit Name", text: $name)
            }
            
            Section("Details") {
                Picker("I want to", selection: $buildHabit) {
                    Text("Build a habit").tag(true)
                    Text("Break a habit").tag(false)
                }
                
                Stepper("How often per day: \(count)", value: $count, in: 1...99)
            }
            
            Button("Add habit") {
                let newHabit = Habit(name: name, buildHabit: buildHabit, count: count)
                modelContext.insert(newHabit)
                dismiss()
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
}
