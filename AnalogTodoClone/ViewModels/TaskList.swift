//
//  TaskList.swift
//  Today
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
    
    func save() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "savedTasks")
        } catch {
            print("There was an error saving the task data.")
        }
    }
    
    func addTask(_ text: String) {
        guard text != "" else { return }
        guard tasks.count < TaskList.taskLimit else { return }
        
        let newTask = Task(name: text)
        tasks.append(newTask)
        save()
    }
    
    func update(_ oldTask: Task, to newTask: Task) {
        if let index = tasks.firstIndex(of: oldTask) {
            tasks[index] = newTask
            save()
        }
    }
    
    func deleteTask(_ task: Task) {
        guard let indexToRemove = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: indexToRemove)
        save()
    }
    
    func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        save()
    }
    
    func reorderTasks(fromOffsets indexSet: IndexSet, toOffset index: Int) {
        tasks.move(fromOffsets: indexSet, toOffset: index)
        save()
    }
    
    func completeTask(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .complete)
        update(task, to: updatedTask)
    }

    func markTaskInProgress(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .inProgress)
        update(task, to: updatedTask)
    }

    func markTaskTonight(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .tonight)
        update(task, to: updatedTask)
    }

    func markTaskTomorrow(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .tomorrow)
        update(task, to: updatedTask)
    }
    
    func markTaskEvent(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .event)
        update(task, to: updatedTask)
    }

    func markTaskNoneAction(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .none)
        update(task, to: updatedTask)
    }
    
    func markTaskPriority(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .priority)
        update(task, to: updatedTask)
    }
}
