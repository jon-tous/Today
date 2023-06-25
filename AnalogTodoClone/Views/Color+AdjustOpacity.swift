//
//  Color+AdjustOpacity.swift
//  AnalogTodo
//
//  Created by Jon Toussaint on 6/25/23.
//

import SwiftUI

extension Color {
    func adjustOpacity(forIndex index: Int) -> Color {
        guard (0...9).contains(index) else { return self }
        return self.opacity(1.0 - Double(index) / 10)
    }
}
