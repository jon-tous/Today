//
//  NoneShape.swift
//  Today
//
//  Created by Jon Toussaint on 4/16/23.
//

import SwiftUI

struct NoneShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}

struct NoneShape_Previews: PreviewProvider {
    static var previews: some View {
        NoneShape()
            .stroke(style: StrokeStyle(lineWidth: 5))
            .frame(width: 60, height: 60)
    }
}
