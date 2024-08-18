import Foundation
import SwiftUI

class PomodoroTimerModel: ObservableObject {
    @Published var timer = PomodoroTimerController()
    
    var backgroundColor: Color {
        switch timer.mode {
        case .work:
            if(timer.active){
                return getWorkColor(type: "light")
            } else{
                return getWorkColor(type: "dark")
            }
        case .shortBreak:
            if(timer.active){
                return getShortBreakColor(type: "light")
            } else{
                return getShortBreakColor(type: "dark")
            }
        case .longBreak:
            if(timer.active){
                return getLongBreakColor(type: "light")
            } else{
                return getLongBreakColor(type: "dark")
            }
        }
    }
    
    func getWorkColor(type: String) -> Color {
        if(type == "light"){
            return Color(#colorLiteral(red: 0.9251871705, green: 0.2044613659, blue: 0.2209115028, alpha: 1))
        } else if(type == "dark"){
            return Color(#colorLiteral(red: 0.6020421386, green: 0.1364201903, blue: 0.1451157629, alpha: 1))
        } else{
            return Color(#colorLiteral(red: 0.4302163124, green: 0.1238558367, blue: 0.1268460751, alpha: 1))
        }
    }
    
    func getShortBreakColor(type: String) -> Color {
        if(type == "light"){
            return Color(#colorLiteral(red: 0, green: 0.6053224206, blue: 0.3644704819, alpha: 1))
        } else if(type == "dark"){
            return Color(#colorLiteral(red: 0, green: 0.4072577357, blue: 0.2454426289, alpha: 1))
        } else{
            return Color(#colorLiteral(red: 0.1404717565, green: 0.3077472448, blue: 0.2266814709, alpha: 1))
        }
    }
    
    func getLongBreakColor(type: String) -> Color {
        if(type == "light"){
            return Color(#colorLiteral(red: 0.161991179, green: 0.4409264922, blue: 0.7198373675, alpha: 1))
        } else if(type == "dark"){
            return Color(#colorLiteral(red: 0.1185685769, green: 0.3155369759, blue: 0.5151882768, alpha: 1))
        } else{
            return Color(#colorLiteral(red: 0.134239912, green: 0.24499318, blue: 0.3638466001, alpha: 1))
        }
    }
    
    func getSelectedTime() -> Int {
        if(timer.getSelectedMode() == "work"){
            return timer.getWorkTime()
        } else if(timer.getSelectedMode() == "shortBreak"){
            return timer.getShortTime()
        } else{
            return timer.getLongTime()
        }
    }
    
    func incrementTime(){
        if(timer.getSelectedMode() == "work"){
            return self.setWorkTime(input: timer.getWorkTime() + 1)
        } else if(timer.getSelectedMode() == "shortBreak"){
            return self.setShortBreak(input: timer.getShortTime() + 1)
        } else{
            return self.setLongBreak(input: timer.getLongTime() + 1)
        }
    }
    
    func decrementTime(){
        if(timer.getSelectedMode() == "work"){
            return self.setWorkTime(input: timer.getWorkTime() - 1)
        } else if(timer.getSelectedMode() == "shortBreak"){
            return self.setShortBreak(input: timer.getShortTime() - 1)
        } else{
            return self.setLongBreak(input: timer.getLongTime() - 1)
        }
    }
    
    func revertSettings(){
        timer.setSelectedMode(method: "work")
        self.setWorkTime(input: timer.getDefaultWorkTime())
        self.setShortBreak(input: timer.getDefaultShortTime())
        self.setLongBreak(input: timer.getDefaultLongTime())
        timer.resetTimer()
    }
    
    func getTimerIcon(modeType: String) -> String {
        switch modeType {
        case "work":
            if timer.getWorkTime() < 10 {
                return "0\(timer.getWorkTime()).circle.fill"
            } else {
                return "\(timer.getWorkTime()).circle.fill"
            }
        case "shortBreak":
            if timer.getShortTime() < 10 {
                return "0\(timer.getShortTime()).circle.fill"
            } else {
                return "\(timer.getShortTime()).circle.fill"
            }
        case "longBreak":
            if timer.getLongTime() < 10 {
                return "0\(timer.getLongTime()).circle.fill"
            } else {
                return "\(timer.getLongTime()).circle.fill"
            }
        default:
            return ""
        }
    }
    
    func getMode(timerType: String) -> String {
        return timer.getMode(timerType: timerType)
    }
    
    func adjustTimeAmount(method: String){
        timer.setSelectedMode(method: method)
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
    
    func getDefaultWorkTime() -> Int {
        return timer.getDefaultWorkTime()
    }
    
    func getDefaultShortTime() -> Int {
        return timer.getDefaultShortTime()
    }
    
    func getDefaultLongTime() -> Int {
        return timer.getDefaultLongTime()
    }
    
    func resetTimer(){
        timer.resetTimer()
    }
    
    func getSelectedMode() -> String? {
        return timer.getSelectedMode()
    }
    
    func getFont() -> String {
        return "Courier"
    }
}
