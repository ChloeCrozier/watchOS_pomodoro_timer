import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var timer = PomodoroTimer()
    
    
    var backgroundColor: Color {
        switch timer.mode {
        case .work:
            return getWorkColor()
        case .shortBreak:
            return getShortBreakColor()
        case .longBreak:
            return getLongBreakColor()
        }
    }
    
    func getWorkColor() -> Color {
        if(timer.active){
            return Color.red.opacity(0.7)
        } else{
            return Color.red.opacity(0.4)
        }
    }
    
    func getShortBreakColor() -> Color {
        if(timer.active){
            return Color.green.opacity(0.6)
        } else{
            return Color.green.opacity(0.3)
        }
    }
    
    func getLongBreakColor() -> Color {
        if(timer.active){
            return Color.blue.opacity(0.7)
        } else{
            return Color.blue.opacity(0.3)
        }
    }
    
    func startStop() {
        print("starting or stopping")
        timer.startStop()
    }
    
    func startNextMode() {
        timer.startNextMode()
    }
    
    func startWork(method: String){
        timer.startWork(method: method)
    }
    
    func startShortBreak(method: String){
        timer.startShortBreak(method: method)
    }
    
    func startLongBreak(method: String){
        timer.startLongBreak(method: method)
    }
    
    func setWorkTime(input: Int){
        timer.updateWorkTime(newTime: input)
    }
    
    func setShortBreak(input: Int){
        timer.updateShortTime(newTime: input)
    }
    
    func setLongBreak(input: Int){
        timer.updateLongTime(newTime: input)
    }
    
    func getTimeRemaining() -> String {
        return timer.getTimeRemaining()
    }
    
    func getStatus() -> Bool {
        return timer.active
    }
    
    func getWorkCycles() -> Int {
        return timer.workCycles
    }
    
    func getMode() -> String {
        if(timer.mode == .work){
            return "Pomodoro"
        } else if(timer.mode == .shortBreak){
            return "Short Break"
        } else{
            return "Long Break"
        }
    }
    
    func getWorkTime() -> Int {
        return timer.workTime
    }
    
    func getShortTime() -> Int {
        return timer.shortTime
    }
    
    func getLongTime() -> Int {
        return timer.longTime
    }
}
