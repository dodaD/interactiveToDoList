//
//  ScheduleView.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 25.04.2025.
//


import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Environment(ModelData.self) var modelData
    @State private var date = Date()
    @State private var selectedTaskID: Int? = nil
    
    var body: some View {
        VStack{
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .labelsHidden()
            .datePickerStyle(.graphical)
        }.padding()
        Spacer()
        
        
        let selectedDate = date.formatted(date: .long, time: .omitted)
        List(modelData.tasks, selection: $selectedTaskID) { task in
            VStack {
                Text(task.task)
            }
            
            /*if task.id == selectedTaskID {
                task.date = selectedDate
            }*/
        }
    }
}

#Preview {
    ScheduleView()
}

