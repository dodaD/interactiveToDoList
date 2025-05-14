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
    @State var doneTasks: [Task] = []
    @State var notDoneTasks: [Task] = []

    func getTasksWithTheDate () {
        let selectedDate = date.formatted(date: .long, time: .omitted)
        self.tasksModel = DatabaseManager().getScheduledTasksForDate(dateToFind: selectedDate)
        
        doneTasks = tasksModel.filter{$0.state}
        notDoneTasks = tasksModel.filter{!$0.state}
    }
    
    func updateList (taskId: Int, isDone: Bool) {
        if (isDone) {
            let doneTask = notDoneTasks.filter{$0.id == taskId}
            notDoneTasks = notDoneTasks.filter{$0.id != taskId}
            doneTasks.append(contentsOf: doneTask)
            return
        }
        
        let undoneTask = doneTasks.filter{$0.id == taskId}
        doneTasks = doneTasks.filter{$0.id != taskId}
        notDoneTasks.append(contentsOf: undoneTask)
    }
 
    var body: some View {
        
        VStack{
            DatePicker (
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
            Section(header: Text("Tasks to be completed")) {
                ForEach(notDoneTasks) { task in
                        TaskComponent(model: task, onGetTasks: { id, state in
                            getTasksWithTheDate()
                        })
                }
                .listRowSeparator(.hidden)
            }
            
            Section(header: Text("Done tasks")) {
                ForEach(doneTasks) { task in
                        TaskComponent(model: task, onGetTasks: { id, state in
                            updateList(taskId: id, isDone: state)
                        })
                }
                .listRowSeparator(.hidden)
                .strikethrough()
                .foregroundStyle(Color.gray)
            }
            //TO-DO: create a component for completed list and not
        }
        
    }
    
}

    

#Preview {
    CalendarView()
}
