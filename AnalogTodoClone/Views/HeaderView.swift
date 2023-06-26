//
//  HeaderView.swift
//  Today
//
//  Created by Jon Toussaint on 6/25/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            todayHeading
            Spacer()
            dateHeading
        }
        .padding(.horizontal)
    }
    
    var todayHeading: some View {
        Text("Today")
            .customFont(relativeTo: .largeTitle)
            .bold()
    }

    var dateHeading: some View {
        Text(
            Date().formatted(Date.FormatStyle().weekday(.abbreviated))
            + " " + Date().formatted(Date.FormatStyle().month(.abbreviated))
            + " " + Date().formatted(Date.FormatStyle().day(.defaultDigits))
        )
        .customFont(relativeTo: .callout)
        .foregroundColor(.secondary)
    }
}
