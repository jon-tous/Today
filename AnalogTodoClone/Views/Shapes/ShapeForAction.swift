//
//  ShapeForAction.swift
//  Today
//
//  Created by Jon Toussaint on 4/16/23.
//

import SwiftUI

struct ShapeForAction: View {
    let action: Action
    
    var body: some View {
        switch action {
        case .none:
            NoneShape()
                .stroke(lineWidth: 1)
                .foregroundColor(.secondary.opacity(1.3))
                .frame(width: 32, height: 32)
        case .inProgress:
            InProgressShape()
                .fill(.secondary.opacity(1.3))
                .frame(width: 32, height: 32)
        case .tonight:
            TonightShape()
                .fill(.secondary.opacity(1.3))
                .rotationEffect(.degrees(-40))
                .frame(width: 32, height: 32)
        case .tomorrow:
            TomorrowShape()
                .stroke(lineWidth: 1)
                .foregroundColor(.secondary.opacity(1.3))
                .frame(width: 32, height: 32)
        case .complete:
            Circle()
                .fill(.secondary.opacity(1.3))
                .frame(width: 32, height: 32)
        case .event:
            EventShape()
                .stroke(lineWidth: 1)
                .foregroundColor(.secondary.opacity(1.3))
                .frame(width: 32, height: 32)
        case .priority:
            PriorityShape()
                .foregroundColor(.secondary.opacity(1.3))
                .frame(width: 32, height: 32)
        }
    }
}

struct ShapeForAction_Previews: PreviewProvider {
    
    static var underlyingCircle: some View {
        Circle().stroke()
            .foregroundColor(.secondary)
            .frame(width: 32)
    }
    static var previews: some View {
        VStack(alignment: .leading, spacing: 40) {
//        HStack(spacing: 20) {
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .none)
                }
                Text("To-Do")
                    .customFont(relativeTo: .body)
            }
            
            
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .inProgress)
                }
                Text("In Progress")
                    .customFont(relativeTo: .body)
            }
            
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .tonight)
                }
                Text("Tonight")
                    .customFont(relativeTo: .body)
            }
            
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .tomorrow)
                }
                Text("Tomorrow")
                    .customFont(relativeTo: .body)
            }
            
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .complete)
                }
                Text("Complete")
                    .customFont(relativeTo: .body)
            }
            
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .event)
                }
                Text("Event")
            }
            
            HStack(spacing: 15) {
                ZStack {
                    ShapeForAction_Previews.underlyingCircle
                    ShapeForAction(action: .priority)
                }
                Text("Priority")
            }
        }
    }
}
