//
//  EmptyTaskRowView.swift
//  AnalogTodo
//
//  Created by Jon Toussaint on 6/25/23.
//

import SwiftUI

struct EmptyTaskRowView: View {
    let index: Int
    
    var body: some View {
        HStack {
            emptyTaskCircle(for: index)
            emptyTaskDisplayText(for: index)
        }
    }
    
    func emptyTaskCircle(for index: Int) -> some View {
        Circle()
            .foregroundColor(.secondary.adjustOpacity(forIndex: index))
            .frame(width: 32)
    }
    
    func emptyTaskDisplayText(for index: Int) -> some View {
        Text("Task \(index + 1)")
            .customFont(relativeTo: .body)
            .foregroundColor(.secondary.opacity(0.4))
            .padding(.leading)
    }
}

struct EmptyTaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTaskRowView(index: 0)
    }
}
