// Viewer made to display the time calcualted by the timer controller
import SwiftUI

struct PomodoroTimeView: View {
    @ObservedObject var model = PomodoroTimerModel()
    
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
    @ObservedObject var model: PomodoroTimerModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(model.getMode(timerType: "active")) #\(model.getWorkCycles())")
                    .font(.custom(model.getFont(), fixedSize: 18))
            }
            Text(model.getTimeRemaining())
                .font(.custom(model.getFont(), size: 35))
                .padding(.top, 10)
                .padding(.bottom,7)
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
                        .frame(width: 50, height: 50)
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
    @ObservedObject var model: PomodoroTimerModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quick Select")
                .font(.custom(model.getFont(), fixedSize: 18))
            Button(action: {
                model.startWork(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "work"))
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(model.getMode(timerType: "work"))
                    .font(.custom(model.getFont(), fixedSize: 16))
                    .padding()
                    .background(model.getWorkColor(type: "button"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical, 3)
            Button(action: {
                model.startShortBreak(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "shortBreak"))
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(model.getMode(timerType: "shortBreak"))
                    .font(.custom(model.getFont(), fixedSize: 16))
                    .padding()
                    .background(model.getShortBreakColor(type: "button"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical, 3)
            Button(action: {
                model.startLongBreak(method: "select")
            }) {
                Image(systemName: model.getTimerIcon(modeType: "longBreak"))
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(model.getMode(timerType: "longBreak"))
                    .font(.custom(model.getFont(), fixedSize: 16))
                    .padding()
                    .background(model.getLongBreakColor(type: "button"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical, 5)
        }
    }
}

struct TimeAdjustmentView: View {
    @ObservedObject var model: PomodoroTimerModel
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    model.adjustTimeAmount(method: "work")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "work"))
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(10)
                        .background(model.getWorkColor(type: "button"))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(model.getSelectedMode() == "work" ? Color.gray : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    model.adjustTimeAmount(method: "shortBreak")
                }) {
                    Image(systemName: model.getTimerIcon(modeType: "shortBreak"))
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(10)
                        .background(model.getShortBreakColor(type: "button"))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(model.getSelectedMode() == "shortBreak" ? Color.gray : Color.clear, lineWidth: 2)
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
                        .frame(width: 35, height: 35)
                        .padding(10)
                        .background(model.getLongBreakColor(type: "button"))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(model.getSelectedMode() == "longBreak" ? Color.gray : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    model.revertSettings()
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
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
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                Text("\(model.getSelectedTime())")
                    .font(.custom(model.getFont(), fixedSize: 28))
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Button(action: {
                    model.incrementTime()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top, 2)
        }
    }
}

#Preview {
    PomodoroTimeView()
}
