//
//  AddTaskView.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/15/23.
//

//import SwiftUI
//
//struct AddTaskView: View {
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var existingTasks: TaskList
//    @State private var taskText = ""
//    @State private var showingAlert = false
//
//    let alertTitle = "Your plate is full!"
//    let alertMessage = "You already have 10 todos for the day. Please delete one and try again."
//
//    var body: some View {
//        HStack {
//            TextField("New Task", text: $taskText, onCommit: save)
//            Button {
//                save()
//            } label: {
//                Image(systemName: "plus")
//                    .foregroundColor(.primary)
//            }
//            .buttonStyle(.borderless)
//            .alert(alertTitle, isPresented: $showingAlert, actions: { }) {
//                Text(alertMessage)
//            }
//        }
//        .padding(.leading)
//    }
//
//    func save() {
//        guard taskText != "" else { return }
//
//        // Enforce 10 task limit
//        if existingTasks.tasks.count == 10 {
//            showingAlert = true
//            return
//        }
//
//        // Add task to TaskList task array and re-save to UserDefaults
//        let newTask = Task(name: taskText)
//        existingTasks.addTask(newTask)
//
//        dismiss()
//    }
//}
//
//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView()
//            .environmentObject(TaskList())
//    }
//}
