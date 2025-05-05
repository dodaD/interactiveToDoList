//
//  TaskComponent.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 30.04.2025.
//

import SwiftUI

struct TaskComponent: View {
    @State var model: Task
    @State private var doesClose = false
    @State private var previousDoesClose = false
    var onDelete: () -> Void
    
    func completeTask() {
        if(previousDoesClose == doesClose) {
            return
        }
        let dbManager: DatabaseManager = DatabaseManager()
        dbManager.updateTaskStatus(newStatus: doesClose, idValue: model.id)
            
        previousDoesClose = doesClose
        onDelete()
        //Being called two times? possible bug
    }
    
    var body: some View {
        HStack {
            Toggle("", isOn: $doesClose)
                .onChange(of: doesClose) { newValue in
                // This code runs when `doesClose` changes
                    completeTask()
                }.onAppear(perform: {
                    doesClose = model.state
                    previousDoesClose = model.state
                })
            .toggleStyle(CheckboxToggleStyle())
            
            VStack(alignment: .leading) {
                Text(model.task)
                Text(model.description).foregroundColor(.gray)
                
            }.swipeActions(edge: .trailing) {
                Button(action: {
                    let dbManager: DatabaseManager = DatabaseManager()
                    dbManager.deleteTask(idValue: model.id)
                    onDelete()
                }, label: {
                    Text("Delete")
                        .foregroundColor(Color.red)
                }).tint(Color.red)
            }
            .swipeActions(edge: .leading) {
                Button(action: {
                    doesClose = !doesClose
                },
                label: {
                    Text("Complete")
                }).tint(Color.purple)
            }.padding(.vertical, 2)
        }
    }
}
