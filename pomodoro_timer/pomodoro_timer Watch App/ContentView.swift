//
//  ContentView.swift
//  pomodoro_timer Watch App
//
//  Created by Chloe Crozier on 8/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Text("Pomodoro Timer")
            Image("timer_logo")
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
        }
        .padding()
//        .background(Color(.systemGray6))
    }
    .background(
        Color.gray
            .opacity(0.4)
    )
}

#Preview {
    ContentView()
}
