// Viewer made to display the time calcualted by the timer controller
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = TimerViewModel()
    
    var body: some View {
        TabView {
            TimerView(model: model)
                .tabItem {
                    Image(systemName: model.getTimerIcon(modeType: "work"))
                }
                .padding()
            
            ModeSelectionView(model: model)
                .tabItem {
                    Image(systemName: "circle.fill")
                    Text("Modes")
                }
                .padding()
            TimeAdjustmentView(model: model)
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
                Text("\(model.getMode(timerType: "active")) #\(model.getWorkCycles())")
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
                Image(systemName: model.getTimerIcon(modeType: "work"))
                Text(model.getMode(timerType: "work"))
                    .font(.body)
                    .padding()
                    .background(model.getWorkColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                model.startShortBreak(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "shortBreak"))
                Text(model.getMode(timerType: "shortBreak"))
                    .font(.body)
                    .padding()
                    .background(model.getShortBreakColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                model.startLongBreak(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "longBreak"))
                Text(model.getMode(timerType: "longBreak"))
                    .font(.body)
                    .padding()
                    .background(model.getLongBreakColor().opacity(6))
                    .foregroundColor(.white)
                    .cornerRadius(10)

            }
        }
    }
}

struct TimeAdjustmentView: View {
    @ObservedObject var model: TimerViewModel
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    model.adjustTimeAmount(method: "work")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "work"))
                        .padding()
                        .background(model.getWorkColor())
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .border(model.selectedMode == "work" ? Color.white : Color.clear, width: 1)
                }
                Button(action: {
                    model.adjustTimeAmount(method: "shortBreak")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "shortBreak"))
                        .padding()
                        .background(model.getShortBreakColor())
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .border(model.selectedMode == "shortBreak" ? Color.white : Color.clear, width: 1)
                }
                Button(action: {
                    model.adjustTimeAmount(method: "longBreak")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "longBreak"))
                        .padding()
                        .background(model.getLongBreakColor())
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .border(model.selectedMode == "longBreak" ? Color.white : Color.clear, width: 1)
                }
            }
            HStack{
                Text("\(model.getSelectedTime())")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                VStack {
                    Button(action: {
                        model.incrementTime()
                    }) {
                        Image(systemName: "arrowshape.up.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        model.decrementTime()
                    }) {
                        Image(systemName: "arrowshape.down.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#Preview {
   ContentView()
}
