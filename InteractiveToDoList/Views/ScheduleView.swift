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
    @State private var hasDateChanged = false
    @State private var keyboardHeight: CGFloat = 0
    
    @State private var doesClose = false
    
    func openInputs () {
        if(doesShowInputFields) {
            return
        }
        
        doesShowInputFields = true
    }
    
    func addItem (){
        if(newTask == "") {
            doesShowInputFields = false
            return
        }
        
        do {
            let dbManager = try DatabaseManager()
            dbManager.addTask(taskValue: self.newTask, descriptionValue: self.newTaskDescription, dateValue: self.newTaskDate)
            
            self.tasksModel = DatabaseManager().getTasksWithNoDate()
        } catch {
            print("Failed to connect DatabaseManager:", error)
        }
        
        newTask = ""
        newTaskDescription = ""
        newTaskDate = ""
        doesShowInputFields = false
    }
    
    func assignDate (taskId: Int) {
        let selectedDate = date.formatted(date: .long, time: .omitted)
        let dbManager: DatabaseManager = DatabaseManager()

        dbManager.updateTaskDate(newDate: selectedDate, idValue: taskId)
        
        tasksModel = tasksModel.filter{$0.id != taskId}
        
    }
    
    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
            if let frame = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = frame.height - 10
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.graphical)
            }.onChange(of: date) {
                hasDateChanged = true
            }
            .onAppear(perform: {
                self.tasksModel = DatabaseManager().getTasksWithNoDate()
            })
            .frame(maxHeight: doesShowInputFields ? 200 : .infinity)
            .padding()
            
            
            
            List {
                Section(header: Text("Tasks to be completed:")) {
                    if doesShowInputFields {
                        InputField(task: $newTask, description: $newTaskDescription, date: $newTaskDate)
                        
                        Button(action: addItem) {
                            Label("Save", systemImage: "")
                        }
                    }
                    ForEach(tasksModel) { task in
                        if(!task.state){
                            TaskComponent(model: task, onGetTasks: { id, state in
                                self.tasksModel = DatabaseManager().getTasksWithNoDate()
                            }).onLongPressGesture {
                                assignDate(taskId: task.id)
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            
            
            if !doesShowInputFields {
                Button(action: openInputs) {
                    Label("Add Task", systemImage: "plus.circle")
                }
            }
            
        }.padding(.bottom, keyboardHeight)
            .animation(.easeOut(duration: 0.25), value: keyboardHeight)
    }
}


#Preview {
    ScheduleView()
}

