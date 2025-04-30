//
//  InputFields.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 29.04.2025.
//
import SwiftUI

struct InputField: View {
    @Binding var task: String
    @Binding var description: String
    @Binding var date: String
    @State private var notFormattedDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @State private var doesShowAddDate = false
    
    func toggleDate () {
        doesShowAddDate = !doesShowAddDate;
        date = "";
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("New task")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter new task:", text: $task)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("New task's description")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter new task's description:", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 4)
            
            if(!doesShowAddDate) {
                Button(action: toggleDate) {
                    Label("Add date", systemImage: "")
                }
            }
            
            if(doesShowAddDate) {
                VStack {
                    DatePicker(
                        "Start Date",
                        selection: $notFormattedDate,
                        displayedComponents: [.date]
                    )
                    .onChange(of: notFormattedDate) {
                        date = $0.formatted(date: .long, time: .omitted)
                    }
                    .labelsHidden()
                    
                    Button(action: toggleDate) {
                        Label("Cancel", systemImage: "").font(.caption)
                    }
                }
            }
        }
    }
}
