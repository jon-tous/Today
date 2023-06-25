//
//  Task.swift
//  AnalogTodo
//
//  Created by Jon Toussaint on 4/15/23.
//

import Foundation

enum Action: Codable {
    case none, inProgress, tonight, tomorrow, complete, event, priority
}

struct Task: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var action: Action = .none
    
    static func ==(lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
    
    static var example: Task {
        Task(name: "Do the dishes", action: .inProgress)
    }
}
