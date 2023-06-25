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
    @FocusState private var inputFocus: Bool
    
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
                                .frame(width: 32)
                            ShapeForAction(action: task.action)
                        }
                        
                        Text(task.name)
                            .font(Font.custom("Avenir", size: 17, relativeTo: .body))
                            .strikethrough(task.action == Action.complete)
                            .padding(.leading)
                    }
                    .contextMenu {
                        Button("Complete") { completeTask(task) }
                        Button("In Progress") { markTaskInProgress(task) }
                        Button("Tonight") { markTaskTonight(task) }
                        Button("Tomorrow") { markTaskTomorrow(task) }
                        Button("Event") { markTaskEvent(task) }
                        Button("To Do") { markTaskNoneAction(task) }
                        Divider()
                        Button(role: .destructive) { deleteTask(task) } label: {
                            Text("Delete Task")
                        }

                    }
                }
                .onDelete(perform: removeRows)
                .onMove { indexSet, index in
                    todayTasks.tasks.move(fromOffsets: indexSet, toOffset: index)
                    todayTasks.save()
                }
                .padding(.vertical, 5)
                .listRowSeparator(.hidden)
                
                ForEach(todayTasks.tasks.count..<TaskList.taskLimit, id: \.self) { index in
                    if index == todayTasks.tasks.count {
                        HStack {
                            Button {
                                inputFocus.toggle()
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(
                                            .secondary
                                                .opacity(1.0 - Double(todayTasks.tasks.count)/10)
                                        )
                                        .frame(width: 32)
                                    Image(systemName: "plus")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .rotationEffect(inputFocus ? Angle(degrees: 45) : .zero)
                                        .animation(.default, value: inputFocus)
                                }
                            }
                            
                            TextField("Task \(todayTasks.tasks.count + 1)", text: $taskInput)
                                .font(Font.custom("Avenir", size: 17, relativeTo: .body))
                                .submitLabel(.done)
                                .focused($inputFocus)
                                .onSubmit {
                                    addTask()
                                }
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
                                .frame(width: 32)
                            Text("Task \(index + 1)")
                                .font(Font.custom("Avenir", size: 17, relativeTo: .body))
                                .padding(.leading)
                                
                        }
                        .foregroundColor(.secondary.opacity(0.4))
                    }
                    
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 5)
//                .scrollDismissesKeyboard(.interactively)
            }
            .listStyle(.plain)
        }
        .padding()
        .dynamicTypeSize(...DynamicTypeSize.accessibility1)
        .onAppear {
            todayTasks.fetchData()
        }
        
    }
    
    var todayHeading: some View {
        Text("Today")
            .font(Font.custom("Avenir Heavy", size: 34, relativeTo: .largeTitle))
            .bold()
    }
    
    var dateHeading: some View {
        Text(
            Date().formatted(Date.FormatStyle().weekday(.abbreviated))
            + " " + Date().formatted(Date.FormatStyle().month(.abbreviated))
            + " " + Date().formatted(Date.FormatStyle().day(.defaultDigits))
        )
        .font(Font.custom("Avenir", size: 16, relativeTo: .callout))
        .foregroundColor(.secondary)
    }
    
    var headerRow: some View {
        HStack {
            todayHeading
            Spacer()
            dateHeading
        }
    }
    
    // MARK: Intents
    
    func removeRows(at offsets: IndexSet) {
        todayTasks.tasks.remove(atOffsets: offsets)
        do {
            let data = try JSONEncoder().encode(todayTasks.tasks)
            UserDefaults.standard.set(data, forKey: "savedTasks")
        } catch {
            print("There was an error saving the removed task.")
        }
    }
    
    func deleteTask(_ task: Task) {
        guard let indexToRemove = todayTasks.tasks.firstIndex(of: task) else { return }
        todayTasks.tasks.remove(at: indexToRemove)
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
        
        taskInput = ""
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
    
    func markTaskEvent(_ task: Task) {
        let updatedTask = Task(id: task.id, name: task.name, action: .event)
        
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

