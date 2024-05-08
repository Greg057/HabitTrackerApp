//
//  Habit.swift
//  HabitTracker
//
//  Created by Gregoire Meyer on 07/05/2024.
//

import Foundation
import SwiftData

@Model
class Habit: Identifiable {
    let id = UUID()
    var name: String
    var buildHabit: Bool
    var count: Int
    var isCompleted = false
    
    init(name: String, buildHabit: Bool, count: Int) {
        self.name = name
        self.buildHabit = buildHabit
        self.count = count
    }
}
