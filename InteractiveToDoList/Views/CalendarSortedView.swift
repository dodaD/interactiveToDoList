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
    @State var tasksModel: [Task] = []

    func getTasksWithTheDate () {
        let selectedDate = date.formatted(date: .long, time: .omitted)
        self.tasksModel = DatabaseManager().getScheduledTasksForDate(dateToFind: selectedDate)
    }
 
    var body: some View {
        VStack{
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .labelsHidden()
            .datePickerStyle(.graphical)
        }.onChange(of: date) {
            getTasksWithTheDate()
        }
        .onAppear(perform: {
            getTasksWithTheDate()
        })
        Spacer()
        
        
            
        
        List {
            Section(header: Text("Tasks to be completed:")) {
                ForEach(tasksModel) { task in
                    if(!task.state){
                        TaskComponent(model: task, onGetTasks: {
                            self.tasksModel = DatabaseManager().getTasksWithNoDate()
                        })
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        
    }
    
}

    

#Preview {
    CalendarView()
}
