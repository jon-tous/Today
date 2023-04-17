//
//  ContentView.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todayTasks = TaskList()
    @State private var taskInput = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            headerRow
                .padding(.horizontal)
            Spacer()
            List {
                ForEach(todayTasks.tasks) { task in
                    HStack {
                        ZStack {
                            Circle()
                                .stroke()
                                .foregroundColor(.secondary)
                                .frame(maxWidth: 32)
                            ShapeForAction(action: task.action)
                        }
                        
                        Text(task.name)
                            .padding(.leading)
                    }
                    .contextMenu {
                        Button("Complete") { completeTask(task) }
                        Button("In Progress") { markTaskInProgress(task) }
                        Button("Tonight") { markTaskTonight(task) }
                        Button("Tomorrow") { markTaskTomorrow(task) }
                        Button("To Do") { markTaskNoneAction(task) }
                    }
                }
                .onDelete(perform: removeRows)
                .onMove { indexSet, index in
                    todayTasks.tasks.move(fromOffsets: indexSet, toOffset: index)
                    todayTasks.save()
                }
                .padding(.vertical, 10)
                .listRowSeparator(.hidden)
                
                ForEach(todayTasks.tasks.count..<TaskList.taskLimit, id: \.self) { index in
                    if index == todayTasks.tasks.count {
                        HStack {
                            Button {
                                addTask()
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(
                                            .secondary
                                                .opacity(1.0 - Double(todayTasks.tasks.count)/10)
                                        )
                                        .frame(maxWidth: 32)
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                }
                            }
                            
                            TextField("Task \(todayTasks.tasks.count + 1)", text: $taskInput, onCommit: addTask)
                                .padding(.leading)
                        }
                    } else {
                        HStack {
                            Circle()
                                .foregroundColor(
                                    .secondary
                                        .opacity(1 - Double(index) / 10)
                                )
                                .foregroundColor(.secondary)
                                .frame(maxWidth: 32)
                            Text("Task \(index + 1)")
                                .padding(.leading)
                                
                        }
                        .foregroundColor(.secondary.opacity(0.4))
                    }
                    
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 5)
            }
            .listStyle(.plain)
        }
        .padding()
        .onAppear {
            todayTasks.fetchData()
        }
        
    }
    
    var todayHeading: some View {
        Text("Today")
            .font(.largeTitle)
            .bold()
    }
    
    var dateHeading: some View {
        Text(Date().formatted(date: .abbreviated, time: .omitted))
            .font(.callout)
            .foregroundColor(.secondary)
    }
    
    var headerRow: some View {
        HStack {
            todayHeading
            Spacer()
            dateHeading
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        todayTasks.tasks.remove(atOffsets: offsets)
        do {
            let data = try JSONEncoder().encode(todayTasks.tasks)
            UserDefaults.standard.set(data, forKey: "savedTasks")
        } catch {
            print("There was an error saving the removed task.")
        }
    }
    
    func addTask() {
        guard taskInput != "" else { return }
        
        // Add task to TaskList task array and re-save to UserDefaults
        let newTask = Task(name: taskInput)
        todayTasks.addTask(newTask)
        
        taskInput = "" // TODO: debug this isn't clearing the input
    }
    
    func completeTask(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .complete)
        
        if let index = todayTasks.tasks.firstIndex(of: task) {
            todayTasks.tasks[index] = updatedTask
            todayTasks.save()
        }
    }

    func markTaskInProgress(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .inProgress)
        
        if let index = todayTasks.tasks.firstIndex(of: task) {
            todayTasks.tasks[index] = updatedTask
            todayTasks.save()
        }
    }

    func markTaskTonight(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .tonight)
        
        if let index = todayTasks.tasks.firstIndex(of: task) {
            todayTasks.tasks[index] = updatedTask
            todayTasks.save()
        }
    }

    func markTaskTomorrow(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .tomorrow)
        
        if let index = todayTasks.tasks.firstIndex(of: task) {
            todayTasks.tasks[index] = updatedTask
            todayTasks.save()
        }
    }

    func markTaskNoneAction(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .none)
        
        if let index = todayTasks.tasks.firstIndex(of: task) {
            todayTasks.tasks[index] = updatedTask
            todayTasks.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
