import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var timer = PomodoroTimer()
    @Published var selectedMode: String? = "work"
    
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
    
    func getSelectedTime() -> Int {
        if(selectedMode == "work"){
            return timer.getWorkTime()
        } else if(selectedMode == "shortBreak"){
            return timer.getShortTime()
        } else{
            return timer.getLongTime()
        }
    }
    
    func incrementTime(){
        if(selectedMode == "work"){
            return self.setWorkTime(input: timer.getWorkTime() + 1)
        } else if(selectedMode == "shortBreak"){
            return self.setShortBreak(input: timer.getShortTime() + 1)
        } else{
            return self.setLongBreak(input: timer.getLongTime() + 1)
        }
    }
    
    func decrementTime(){
        if(selectedMode == "work"){
            return self.setWorkTime(input: timer.getWorkTime() - 1)
        } else if(selectedMode == "shortBreak"){
            return self.setShortBreak(input: timer.getShortTime() - 1)
        } else{
            return self.setLongBreak(input: timer.getLongTime() - 1)
        }
    }
    
    func getTimerIcon(modeType: String) -> String {
        return timer.getTimerIcon(modeType: modeType)
    }
    
    func getMode(timerType: String) -> String {
        return timer.getMode(timerType: timerType)
    }
    
    func adjustTimeAmount(method: String){
        self.selectedMode = method
    }
    
    func startStop() {
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
        timer.setTime()
    }
    
    func setShortBreak(input: Int){
        timer.updateShortTime(newTime: input)
        timer.setTime()
    }
    
    func setLongBreak(input: Int){
        timer.updateLongTime(newTime: input)
        timer.setTime()
    }
    
    func getTimeRemaining() -> String {
        return timer.getTimeRemaining()
    }
    
    func getStatus() -> Bool {
        return timer.active
    }
    
    func getWorkCycles() -> Int {
        return timer.getWorkCycles()
    }
    
    func getWorkTime() -> Int {
        return timer.getWorkTime()
    }
    
    func getShortTime() -> Int {
        return timer.getShortTime()
    }
    
    func getLongTime() -> Int {
        return timer.getLongTime()
    }
}
