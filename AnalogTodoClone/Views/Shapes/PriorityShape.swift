//
//  PriorityShape.swift
//  Today
//
//  Created by Jon Toussaint on 6/25/23.
//

import SwiftUI

struct PriorityShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: min(rect.midX, rect.midY)/4, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        
        return path
    }
}

struct PriorityShape_Previews: PreviewProvider {
    static var previews: some View {
        PriorityShape()
            .foregroundColor(.secondary.opacity(1.3))
            .frame(width: 60, height: 60)
    }
}

