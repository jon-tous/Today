//
//  View+CustomFont.swift
//  Today
//
//  Created by Jon Toussaint on 6/25/23.
//

import SwiftUI

struct CustomFont: ViewModifier {
    var fontName: String
    var size: CGFloat
    var relativeTo: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(fontName, size: size, relativeTo: relativeTo))
    }
}

extension View {
    func customFont(relativeTo textStyle: Font.TextStyle) -> some View {
        switch textStyle {
        case .largeTitle:
            return self.modifier(CustomFont(fontName: "Avenir Heavy", size: 34, relativeTo: .largeTitle))
        case .callout:
            return self.modifier(CustomFont(fontName: "Avenir", size: 16, relativeTo: .callout))
        default:
            return self.modifier(CustomFont(fontName: "Avenir", size: 17, relativeTo: .body))
        }
    }
}
