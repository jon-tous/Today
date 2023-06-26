//
//  TomorrowShape.swift
//  Today
//
//  Created by Jon Toussaint on 4/16/23.
//

import SwiftUI

struct TomorrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
    
    
}

struct TomorrowShape_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowShape()
            .stroke(style: StrokeStyle(lineWidth: 5))
            .frame(width: 60, height: 60)
    }
}
