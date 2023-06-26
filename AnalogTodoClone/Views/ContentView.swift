//
//  ContentView.swift
//  Today
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
            HeaderView()
            Spacer()
            
            // MARK: Existing tasks
            List {
                ForEach(todayTasks.tasks) { task in
                    HStack {
                        taskCircle(for: task)
                        taskDisplayText(for: task)
                    }
                    .contextMenu {
                        Button("Complete") { todayTasks.completeTask(task) }
                        Button("In Progress") { todayTasks.markTaskInProgress(task) }
                        Button("Tonight") { todayTasks.markTaskTonight(task) }
                        Button("Tomorrow") { todayTasks.markTaskTomorrow(task) }
                        Button("Event") { todayTasks.markTaskEvent(task) }
                        Button("Priority") { todayTasks.markTaskPriority(task) }
                        Button("To Do") { todayTasks.markTaskNoneAction(task) }
                        Divider()
                        Button(role: .destructive) { todayTasks.deleteTask(task) } label: { Text("Delete Task") }
                    }
                    .swipeActions(edge: .leading) {
                        Button { task.action == .complete ? todayTasks.markTaskNoneAction(task) : todayTasks.completeTask(task) }
                            label: { Text("Complete") }
                                .tint(Color.secondary.adjustOpacity(forIndex: todayTasks.tasks.firstIndex(of: task) ?? 0))
                    }
                }
                .onDelete(perform: removeRows)
                .onMove(perform: moveRows)
                .padding(.vertical, 5)
                .listRowSeparator(.hidden)
                
                // MARK: Empty task slots
                ForEach(todayTasks.tasks.count..<TaskList.taskLimit, id: \.self) { index in
                    if index == todayTasks.tasks.count {
                        HStack {
                            Button { inputFocus.toggle() } label: { addTaskCircle }
                            taskTextField
                        }
                    } else {
                        EmptyTaskRowView(index: index)
                    }
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 5)
            }
            .listStyle(.plain)
        }
        .padding()
        .dynamicTypeSize(...DynamicTypeSize.accessibility1)
        .onAppear { todayTasks.fetchData() }
    }
    
    // MARK: Subviews for existing tasks
    
    func taskCircle(for task: Task) -> some View {
        ZStack {
            Circle()
                .stroke()
                .foregroundColor(.secondary)
                .frame(width: 32)
            ShapeForAction(action: task.action)
        }
    }
    
    func taskDisplayText(for task: Task) -> some View {
        Text(task.name)
            .customFont(relativeTo: .body)
            .strikethrough(task.action == Action.complete)
            .padding(.leading)
    }
    
    // MARK: Subviews for adding a task
    
    var addTaskCircle: some View {
        ZStack {
            Circle()
                .foregroundColor(.secondary.adjustOpacity(forIndex: todayTasks.tasks.count))
                .frame(width: 32)
            Image(systemName: "plus")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .rotationEffect(inputFocus ? Angle(degrees: 45) : .zero)
                .animation(.default, value: inputFocus)
        }
    }
    
    var taskTextField: some View {
        TextField("Task \(todayTasks.tasks.count + 1)", text: $taskInput)
            .customFont(relativeTo: .body)
            .padding(.leading)
            .submitLabel(.done)
            .focused($inputFocus)
            .onSubmit {
                todayTasks.addTask(taskInput)
                taskInput = ""
            }
    }
    
    // MARK: View functions that affect task data
    
    // Remove rows from view (and task list)
    func removeRows(at offsets: IndexSet) {
        todayTasks.deleteTasks(at: offsets)
    }
    
    // Reorder rows in view (and task list)
    func moveRows(indexSet: IndexSet, index: Int) {
        todayTasks.reorderTasks(fromOffsets: indexSet, toOffset: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

