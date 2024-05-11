//
//  SettingsPage.swift
//  HabitTracker
//
//  Created by Gregoire Meyer on 10/05/2024.
//

import SwiftUI
import SwiftData

struct SettingsPage: View {
    var body: some View {
        Button("tap") {
            let day = Calendar.current.component(.day, from: Date())
            print("\(day)")
        }
    }
}

#Preview {
    SettingsPage()
}
