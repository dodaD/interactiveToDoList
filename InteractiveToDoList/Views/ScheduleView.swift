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
                        
                        Spacer()
                        
                        Button(action: {
                            let dbManager: DatabaseManager = DatabaseManager()
                            dbManager.deleteTask(idValue: model.id)
                            
                            self.tasksModel = DatabaseManager().getTasks()
                        }, label: {
                            Text("Delete")
                                .foregroundColor(Color.red)
                        })
                    }
                }
                
                if doesShowInputFields {
                    InputField(task: $newTask, description: $newTaskDescription, date: $newTaskDate)
                    
                    Button(action: addItem) {
                        Label("Save", systemImage: "")
                    }
                }
            }
           
            
            if !doesShowInputFields {
                Button(action: openInputs) {
                    Label("Add Task", systemImage: "plus.circle")
                }
            }
            
        }.onAppear(perform: {
            self.tasksModel = DatabaseManager().getTasks()
        })
    }
    
}


#Preview {
    ScheduleView()
}

