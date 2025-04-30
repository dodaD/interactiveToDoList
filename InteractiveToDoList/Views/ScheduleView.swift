//
//  ScheduleView.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 25.04.2025.
//


import SwiftUI
import SwiftData

struct ScheduleView: View {
    @State var tasksModel: [Task] = []
    @State private var date = Date()
    @State private var selectedTaskID: Int? = nil
    @State private var doesShowInputFields = false
    @State private var newTask = ""
    
    @State private var doesClose = false
    
    func addItem() {
        if(doesShowInputFields) {
            return
        }
        
        doesShowInputFields = true
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
        }.padding()
        
        
        //let selectedDate = date.formatted(date: .long, time: .omitted)
        
        VStack {
            List {
                ForEach(tasksModel) { model in
                    HStack {
                        Toggle("", isOn: $doesClose)
                            .toggleStyle(CheckboxToggleStyle())
                        VStack(alignment: .leading) {
                            Text(model.task)
                            Text(model.description).foregroundColor(.gray)
                        }
                    }
                }
                
                if doesShowInputFields {
                    InputField(task: $newTask)
                }
            }
            
            Button(action: addItem) {
                Label("Add Task", systemImage: "plus.circle")
            }
        }.onAppear(perform: {
            self.tasksModel = DatabaseManager().getTasks()
        })
    }
    
}


#Preview {
    ScheduleView()
}

