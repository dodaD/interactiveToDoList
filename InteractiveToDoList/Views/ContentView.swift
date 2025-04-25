//
//  ContentView.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 21.04.2025.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @State private var date = Date()

    var body: some View {
        VStack{
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }.padding()
        Spacer()
        
        
        let selectedDate = date.formatted(date: .long, time: .omitted)
        List(tasks) { task in
            if(selectedDate == task.date) {
                TaskRow(task: task)
            }
        }
    }
}

#Preview {
    CalendarView()
}
