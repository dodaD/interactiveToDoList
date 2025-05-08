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
    private var tasks: Table
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
   
    public func getScheduledTasksForDate(dateToFind: String) -> [Task] {
        
        // create empty array
        var tasksModel: [Task] = []
        
        // get all users in descending order
        tasks = tasks.order(id.desc)
        
        // exception handling
        do {
            // loop through all users
            for row in try db.prepare(tasks) {
                if(row[date] != dateToFind) {
                    continue
                }
                
                // create new model in each loop iteration
                let taskModel: Task = Task()
                
                // set values in model from database
                taskModel.id = row[id]
                taskModel.task = row[task]
                taskModel.description = row[description]
                taskModel.date = row[date]!
                taskModel.state = row[state]
                
                // append in new array
                tasksModel.append(taskModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        // return array
        return tasksModel
    }

    public func getTasksWithNoDate() -> [Task] {
        
        // create empty array
        var tasksModel: [Task] = []
        
        // get all users in descending order
        tasks = tasks.order(id.desc)
        
        // exception handling
        do {
            // loop through all users
            for row in try db.prepare(tasks) {
                if(row[date] != "") {
                    continue
                }
                
                // create new model in each loop iteration
                let taskModel: Task = Task()
                
                // set values in model from database
                taskModel.id = row[id]
                taskModel.task = row[task]
                taskModel.description = row[description]
                taskModel.date = row[date]!
                taskModel.state = row[state]
                
                // append in new array
                tasksModel.append(taskModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        // return array
        return tasksModel
    }
    
    public func deleteTask(idValue: Int) {
        do {
            // get user using ID
            let task: Table = tasks.filter(id == idValue)
            
            // run the delete query
            try db.run(task.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /*public func updateUser(idValue: Int64, nameValue: String, emailValue: String, ageValue: Int64) {
     do {
     // get user using ID
     let user: Table = users.filter(id == idValue)
     
     // run the update query
     try db.run(user.update(name <- nameValue, email <- emailValue, age <- ageValue))
     } catch {
     print(error.localizedDescription)
     }
     }
 */
    
    public func updateTaskStatus(newStatus: Bool, idValue: Int) {
        do {
            // get user using ID
            let task: Table = tasks.filter(id == idValue)
            
            // run the update query
            try db.run(task.update(state <- newStatus))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func updateTaskDate(newDate: String, idValue: Int) {
        do {
            // get user using ID
            let task: Table = tasks.filter(id == idValue)
            
            // run the update query
            try db.run(task.update(date <- newDate))
        } catch {
            print(error.localizedDescription)
        }
    }
    

}
    
