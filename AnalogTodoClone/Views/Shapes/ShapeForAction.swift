//
//  ShapeForAction.swift
//  AnalogTodoClone
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
        VStack(spacing: 40) {
            ZStack {
                ShapeForAction_Previews.underlyingCircle
                ShapeForAction(action: .none)
            }
            
            ZStack {
                ShapeForAction_Previews.underlyingCircle
                ShapeForAction(action: .inProgress)
            }
            
            ZStack {
                ShapeForAction_Previews.underlyingCircle
                ShapeForAction(action: .tonight)
            }
            
            ZStack {
                ShapeForAction_Previews.underlyingCircle
                ShapeForAction(action: .tomorrow)
            }
            
            ZStack {
                ShapeForAction_Previews.underlyingCircle
                ShapeForAction(action: .complete)
            }
            
            ZStack {
                ShapeForAction_Previews.underlyingCircle
                ShapeForAction(action: .event)
            }
        }
    }
}
