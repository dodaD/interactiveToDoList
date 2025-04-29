//
//  DatabaseManager.swift
//  InteractiveToDoList
//
//  Created by Doda Diana on 28.04.2025.
//
import SQLite
import Foundation


class DatabaseManager {
    private var db: Connection!
    private let tasks: Table
    private let id: SQLite.Expression<Int>
    private let task: SQLite.Expression<String>
    private let state: SQLite.Expression<Bool>
    private let description: SQLite.Expression<String>
    private let date: SQLite.Expression<String?>
    
    init ()  {
        
        let path: String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
        
        do {
            db = try Connection("\(path)/my_tasks.sqlite")
        } catch {
            print("Failed to open database at path: \(path)")
        }
        tasks = Table("tasks")
        
        id = Expression<Int>("id")
        task = Expression<String>("task")
        state = Expression<Bool>("state")
        description = Expression<String>("description")
        date = Expression<String?>("date")
        
        if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
            
            // if not, then create the table
            do {
                try db.run(tasks.create { t in
                    t.column(id, primaryKey: true)
                    t.column(task)
                    t.column(state)
                    t.column(description)
                    t.column(date)
                })
                UserDefaults.standard.set(true, forKey: "is_db_created")
                print("Database table created successfully.")
            } catch {
                print("Failed to create tasks table.")
            }
            
            // set the value to true, so it will not attempt to create the table again
            UserDefaults.standard.set(true, forKey: "is_db_created")
        }
    }
    
    public func addTask(taskValue: String, descriptionValue: String, dateValue: String?) {
        do {
            try db.run(tasks.insert(task <- taskValue, description <- descriptionValue, date <- dateValue, state <- false))
        } catch {
            print("Hello from the other sideeeee")
        }
    }
    
}
    
