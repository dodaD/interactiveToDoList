//
//  InteractiveToDoListApp.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 21.04.2025.
//

import SwiftUI
import SwiftData

@main
struct InteractiveToDoListApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            //CalendarView()
            //ScheduleView().environment(modelData)
            AddNewTaskView().environment(modelData)

        }
    }
}

