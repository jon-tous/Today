//
//  EventShape.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/18/23.
//

import SwiftUI

struct EventShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
    
    
}

struct EventShape_Previews: PreviewProvider {
    static var previews: some View {
        EventShape()
            .stroke(style: StrokeStyle(lineWidth: 1))
            .frame(width: 32, height: 32)
    }
}
