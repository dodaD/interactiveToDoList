//
//  ContentView.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 21.04.2025.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @State private var date = Date()
    var body: some View {
        VStack{
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }.padding()
        
        Spacer()
    }
}

#Preview {
    CalendarView()
}
