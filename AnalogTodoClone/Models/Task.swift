//
//  Task.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/15/23.
//

import Foundation

enum Action {
    case none, inProgress, tonight, tomorrow, complete
}

struct Task {
    var name: String
    var action: Action = .none
}
