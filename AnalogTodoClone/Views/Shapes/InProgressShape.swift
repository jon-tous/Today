//
//  InProgressShape.swift
//  Today
//
//  Created by Jon Toussaint on 4/16/23.
//

import SwiftUI

struct InProgressShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.midX-rect.minX, rect.midY-rect.minY)
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: false)
        
        return path
    }
}

struct InProgressShape_Previews: PreviewProvider {
    static var previews: some View {
        InProgressShape()
            .fill(.secondary.opacity(1.3))
            .frame(width: 60, height: 60)
    }
}
