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
    @State private var newTaskDescription = ""
    @State private var newTaskDate = ""
    
    @State private var doesClose = false
    
    func openInputs() {
        if(doesShowInputFields) {
            return
        }
        
        doesShowInputFields = true
    }
    
    func addItem(){
        if(newTask == "") {
            doesShowInputFields = false
            return
        }
        
        do {
            let dbManager = try DatabaseManager()
            dbManager.addTask(taskValue: self.newTask, descriptionValue: self.newTaskDescription, dateValue: self.newTaskDate)
            
            self.tasksModel = DatabaseManager().getTasks()
        } catch {
            print("Failed to connect DatabaseManager:", error)
        }
        
        newTask = ""
        newTaskDescription = ""
        newTaskDate = ""
        doesShowInputFields = false
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
        }.onAppear(perform: {
            self.tasksModel = DatabaseManager().getTasks()
        })
        .padding()
        
        
        
        List {
            Section {
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
            } header: {
                Text("Tasks to be completed:")
            }
            .listSectionSeparator(.hidden)
            //TO-DO: create a component for completed list and not
        }
        
        List {
            Section {
                ForEach(tasksModel) { task in
                    if(task.state) {
                        TaskComponent(model: task, onDelete: {
                            self.tasksModel = DatabaseManager().getTasks()
                        })
                    }
                }
                .listRowSeparator(.hidden)
                .strikethrough()
            } header: {
                Text("Done tasks:")
            }
            .listSectionSeparator(.hidden)
            .foregroundStyle(Color.gray)
            //TO-DO: create a component for completed list and not
        }
        
        
        if !doesShowInputFields {
            Button(action: openInputs) {
                Label("Add Task", systemImage: "plus.circle")
            }
        }
        
    }
    
}


#Preview {
    ScheduleView()
}

