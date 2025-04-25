//
//  TasksRow.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 23.04.2025.
//

import SwiftUI


struct TaskRow: View {
    var task: Task
    
    
    var body: some View {
        VStack {
            Text(task.task)
        }
    }
}
