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
                        Button("Complete") { todayTasks.completeTask(task) }
                        Button("In Progress") { todayTasks.markTaskInProgress(task) }
                        Button("Tonight") { todayTasks.markTaskTonight(task) }
                        Button("Tomorrow") { todayTasks.markTaskTomorrow(task) }
                        Button("Event") { todayTasks.markTaskEvent(task) }
                        Button("Priority") { todayTasks.markTaskPriority(task) }
                        Button("To Do") { todayTasks.markTaskNoneAction(task) }
                        Divider()
                        Button(role: .destructive) { todayTasks.deleteTask(task) } label: {
                            Text("Delete Task")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button { todayTasks.completeTask(task) } label: { Text("Complete") }
                            .tint(Color.secondary
                                .opacity(1.0 - Double(todayTasks.tasks.firstIndex(of: task) ?? 0) / 10)
                            )
                    }
                }
                .onDelete(perform: todayTasks.removeRows)
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
                                    todayTasks.addTask(taskInput)
                                    taskInput = ""
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

