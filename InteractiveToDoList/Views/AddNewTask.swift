//
//  AddNewTask.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 28.04.2025.
//

import SwiftUI

struct AddNewTaskView: View {
    
    // create variables to store user input values
    @State var task: String = ""
    @State var description: String = ""
    @State var date: String = ""
    
    // array of user models
    @State var tasksModel: [Task] = []
    
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            List (self.tasksModel) { (model) in
                // show name, email and age horizontally
                VStack {
                    Text(model.task)
                    Spacer()
                    Text(model.description)
                    Spacer()
                    Text("\(model.date)")
                    Spacer()
                    // edit and delete button goes here
                }
            }
        }.onAppear(perform: {
            self.tasksModel = DatabaseManager().getTasks()
        })
        
        VStack {
            // create name field
            TextField("Enter task", text: $task)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            // create email field
            TextField("Enter descr", text: $description)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // create age field, number pad
            TextField("Enter date", text: $date)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            // button to add a user
            Button(action: {
                // call function to add row in sqlite database
                do {
                    let dbManager = try DatabaseManager()
                    dbManager.addTask(taskValue: self.task, descriptionValue: self.description, dateValue: self.date)
                } catch {
                    print("Failed to create DatabaseManager:", error)
                }
                
                
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add task")
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            .padding(.bottom, 10)
        }.padding()
        
    }
}


#Preview {
    AddNewTaskView()
}
