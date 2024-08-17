// Viewer made to display the time calcualted by the timer controller

import SwiftUI

struct ContentView: View {
    @ObservedObject var timer = PomodoroTimer()
//    @ObservedObject var viewModel = TimerViewModel()
    
    
    var body: some View {
           VStack {
               Text(timer.getTimeRemaining())
                   .font(.largeTitle)
               HStack {
                   Button(action: {
                       timer.startStop()
                   }) {
                       Text(timer.active == true ? "Pause" : "Start")
                           .font(.title2)
                           .padding()
                           .background(Color.white)
                           .foregroundColor(.black)
                           .cornerRadius(10)
                   }
               }
           }
           .padding()
       }
    }

#Preview {
   ContentView()
}
