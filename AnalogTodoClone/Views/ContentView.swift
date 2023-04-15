//
//  ContentView.swift
//  AnalogTodoClone
//
//  Created by Jon Toussaint on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            headerRow
            
            Spacer()
            
            ForEach(0..<10) { taskNum in
                HStack {
                    Circle()
                        .stroke()
                        .foregroundColor(.secondary)
                        .frame(maxWidth: 36)
                    Spacer()
                    Text("Task number \(taskNum)")
                }
            }
            Spacer()
            
        }
        .padding()
    }
    
    var todayHeading: some View {
        Text("Today")
            .font(.largeTitle)
        .bold()
    }
    
    var dateHeading: some View {
        Text(Date().formatted(date: .abbreviated, time: .omitted))
            .font(.callout)
            .foregroundColor(.secondary)
    }
    
    var headerRow: some View {
        HStack {
            todayHeading
            Spacer()
            dateHeading
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
