//
//  TonightShape.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/16/23.
//

import SwiftUI

struct TonightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.midX-rect.minX, rect.midY-rect.minY)

        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: false)
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control1: CGPoint(x: rect.midX, y: rect.minY), control2: CGPoint(x: (rect.minX+rect.midX)/2-10, y: rect.midY))

        return path
    }
}

struct TonightShape_Previews: PreviewProvider {
    static var previews: some View {
        TonightShape()
            .fill(.secondary.opacity(1.3))
            .rotationEffect(.degrees(-40))
            .frame(width: 32, height: 32)
    }
}
