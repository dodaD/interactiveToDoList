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
        
        
        //let selectedDate = date.formatted(date: .long, time: .omitted)
        
        VStack {
            List (self.tasksModel) { (model) in
                // show name, email and age horizontally
                VStack {
                    Text(model.task)
                    Text(model.description)
                    Text(model.date)
                    
                    Button(action: {
                        let dbManager: DatabaseManager = DatabaseManager()
                        dbManager.deleteTask(idValue: model.id)
                        
                        self.tasksModel = DatabaseManager().getTasks()
                    }, label: {
                        Text("Delete")
                            .foregroundColor(Color.red)
                    })
                }
            }.padding(10)
        }.onAppear(perform: {
            self.tasksModel = DatabaseManager().getTasks()
        })

    }
}

#Preview {
    ScheduleView()
}

