//
//  ContentView.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 21.04.2025.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(ModelData.self) var modelData
    @State private var date = Date()

    var body: some View {
        VStack{
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .labelsHidden()
            .datePickerStyle(.graphical)
        }
        Spacer()
        
        
        let selectedDate = date.formatted(date: .long, time: .omitted)
            
        List(modelData.tasks) { task in
            if(selectedDate == task.date) {
                TaskRow(task: task)
            }
        }
    }

    
}

#Preview {
    CalendarView().environment(ModelData())
}
