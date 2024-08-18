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
                .padding(.bottom, 10)
                .padding(.horizontal)
            ModeSelectionView(model: model)
                .tabItem {
                    Image(systemName: "circle.fill")
                }
                .padding(.bottom, 20)
                .padding(.horizontal)
            TimeAdjustmentView(model: model)
                .tabItem {
                    Image(systemName: "circle.fill")
                }
                .padding(.bottom, 10)
                .padding(.horizontal)
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
                .padding(.top, 1)
            HStack {
                Button(action: {
                    model.resetTimer()
                }) {
                    Image(systemName: "backward.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(.horizontal, 3)
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    model.startStop()
                }) {
                    Image(systemName: model.getStatus() ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(.horizontal, 3)
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    model.startNextMode()
                }) {
                    Image(systemName: "forward.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(.horizontal, 3)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ModeSelectionView: View {
    @ObservedObject var model: TimerViewModel
    
    var body: some View {
        VStack {
            HStack{
                Text("Quick Select")
                    .font(.body)
                    .frame(alignment: .topLeading)
                Spacer()
            }
            Button(action: {
                model.startWork(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "work"))
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(model.getMode(timerType: "work"))
                    .font(.body)
                    .padding()
                    .background(model.getWorkColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                model.startShortBreak(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "shortBreak"))
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(model.getMode(timerType: "shortBreak"))
                    .font(.body)
                    .padding()
                    .background(model.getShortBreakColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                model.startLongBreak(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "longBreak"))
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(model.getMode(timerType: "longBreak"))
                    .font(.body)
                    .padding()
                    .background(model.getLongBreakColor())
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
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
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(model.getWorkColor())
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(model.selectedMode == "work" ? Color.gray : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    model.adjustTimeAmount(method: "shortBreak")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "shortBreak"))
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(model.getShortBreakColor())
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(model.selectedMode == "shortBreak" ? Color.gray : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
            HStack{
                Button(action: {
                    model.adjustTimeAmount(method: "longBreak")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "longBreak"))
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(model.getLongBreakColor())
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(model.selectedMode == "longBreak" ? Color.gray : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    model.revertSettings()
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }
                .buttonStyle(PlainButtonStyle())
            }
            HStack{
                Button(action: {
                    model.decrementTime()
                }) {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                Text("\(model.getSelectedTime())")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Button(action: {
                    model.incrementTime()
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
   ContentView()
}
