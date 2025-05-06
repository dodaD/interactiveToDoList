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
        
        /*List {
         Section(header: Text("Tasks to be completed:")) {
         if doesShowInputFields {
         InputField(task: $newTask, description: $newTaskDescription, date: $newTaskDate)
         
         Button(action: addItem) {
         Label("Save", systemImage: "")
         }
         }
         ForEach(tasksModel) { task in
         if(!task.state){
         TaskComponent(model: task, onDelete: {
         self.tasksModel = DatabaseManager().getTasks()
         })
         }
         }
         .listRowSeparator(.hidden)
         }
         .listSectionSeparator(.hidden)
         
         Section(header: Text("Done tasks:")) {
         ForEach(tasksModel) { task in
         if(task.state) {
         TaskComponent(model: task, onDelete: {
         self.tasksModel = DatabaseManager().getTasks()
         })
         }
         }
         .listRowSeparator(.hidden)
         .strikethrough()
         .foregroundStyle(Color.gray)
         }
         //TO-DO: create a component for completed list and not
         }
         
        }*/

    }

    
}

#Preview {
    CalendarView().environment(ModelData())
}
