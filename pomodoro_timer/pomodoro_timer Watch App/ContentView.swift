// Viewer made to display the time calcualted by the timer controller
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = TimerViewModel()
    
    var body: some View {
        TabView {
            TimerView(model: model)
                .tabItem {
                    Image(systemName: "circle.fill")
                }
                .padding()
            
            ModeSelectionView(model: model)
                .tabItem {
                    Image(systemName: "circle.fill")
                    Text("Modes")
                }
                .padding()
        }
        .tabViewStyle(PageTabViewStyle())
        .background(model.backgroundColor)
        .onReceive(model.timer.objectWillChange) { _ in
            self.model.objectWillChange.send()
        }
    }
}

struct TimerView: View {
    @ObservedObject var model: TimerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(model.getMode()) #\(model.getWorkCycles())")
                    .font(.title3)
            }
            Text(model.getTimeRemaining())
                .font(.largeTitle)
            HStack {
                Button(action: {
                    model.startStop()
                }) {
                    Image(systemName: model.getStatus() ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                Button(action: {
                    model.startNextMode()
                }) {
                    Image(systemName: "forward.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ModeSelectionView: View {
    @ObservedObject var model: TimerViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                model.startWork(method: "select")
            }) {
                Text("Pomodoro")
                    .font(.body)
                    .padding()
                    .background(model.getWorkColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                model.startShortBreak(method: "select")
            }) {
                Text("Short Break")
                    .font(.body)
                    .padding()
                    .background(model.getShortBreakColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                model.startLongBreak(method: "select")
            }) {
                Text("Long Break")
                    .font(.body)
                    .padding()
                    .background(model.getLongBreakColor().opacity(6))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Text("\(model.getLongTime())")
                    .font(.body)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Button(action: {
                    model.startStop()
                }) {
                    Image(systemName: "arrowshape.up.circle.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
   ContentView()
}
