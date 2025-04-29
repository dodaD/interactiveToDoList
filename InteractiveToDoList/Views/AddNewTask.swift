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
    
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
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
                //DB_Manager().addUser(nameValue: self.name, emailValue: self.email, ageValue: Int64(self.age) ?? 0)
                print("Hi")
                
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add User")
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
