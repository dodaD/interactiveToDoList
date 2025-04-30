//
//  InputFields.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 29.04.2025.
//
import SwiftUI

struct InputField: View {
    @Binding var task: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("New Task")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("Enter new task:", text: $task)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.vertical, 4)
    }
}
