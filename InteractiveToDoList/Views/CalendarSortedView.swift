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
    @State var tasksModel: [Task] = []
    @State var doneTasks: [Task] = []
    @State var notDoneTasks: [Task] = []
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ScheduleView()) {
                    Image(systemName: "chevron.backward")
                    Text("Unscheduled tasks").font(.headline)
                }.frame(maxWidth: .infinity, alignment: .leading)
                 .padding(.leading)
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.graphical)
                .onChange(of: date) { _ in
                    getTasksWithTheDate()
                }
                .onAppear {
                    getTasksWithTheDate()
                }

                Spacer()
                
                List {
                    Section(header: Text("Tasks to be completed")) {
                        ForEach(notDoneTasks) { task in
                            TaskComponent(model: task, onGetTasks: { id, state in
                                getTasksWithTheDate()
                            })
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    Section(header: Text("Done tasks")) {
                        ForEach(doneTasks) { task in
                            TaskComponent(model: task, onGetTasks: { id, state in
                                updateList(taskId: id, isDone: state)
                            })
                        }
                        .listRowSeparator(.hidden)
                        .strikethrough()
                        .foregroundStyle(Color.gray)
                    }
                }
            }
        }
    }
    
    func getTasksWithTheDate() {
        let selectedDate = date.formatted(date: .long, time: .omitted)
        self.tasksModel = DatabaseManager().getScheduledTasksForDate(dateToFind: selectedDate)
        doneTasks = tasksModel.filter { $0.state }
        notDoneTasks = tasksModel.filter { !$0.state }
    }
    
    func updateList(taskId: Int, isDone: Bool) {
        if isDone {
            if let doneTask = notDoneTasks.first(where: { $0.id == taskId }) {
                notDoneTasks.removeAll { $0.id == taskId }
                doneTasks.append(doneTask)
            }
        } else {
            if let undoneTask = doneTasks.first(where: { $0.id == taskId }) {
                doneTasks.removeAll { $0.id == taskId }
                notDoneTasks.append(undoneTask)
            }
        }
    }
}

#Preview {
    CalendarView()
}
