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
}
