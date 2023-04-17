//
//  TaskList.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/15/23.
//

import Foundation

@MainActor class TaskList: ObservableObject {
    @Published var tasks = [Task]()
    
    static let taskLimit = 10
    
    func fetchData() {
        if let data = UserDefaults.standard.data(forKey: "savedTasks") {
            do {
                let retrievedTasks = try JSONDecoder().decode([Task].self, from: data)
                tasks = retrievedTasks
            } catch {
                print("There was an error loading task data.")
            }
        }
    }
    
    func addTask(_ newTask: Task) {
        guard tasks.count < 10 else {
            print("Already 10 tasks - did not save new task.")
            return
        }
        
        tasks.append(newTask)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "savedTasks")
        } catch {
            print("There was an error saving the task data.")
        }
    }
}
