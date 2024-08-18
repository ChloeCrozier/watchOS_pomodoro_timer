// The timing logic behind the pomodoro timer modes
import Foundation
import SwiftUI

enum TimerMode {
    case work
    case shortBreak
    case longBreak
}

class PomodoroTimerController: ObservableObject {
    private static let minutes = 60
    private static let maxCycles = 4
    private static let defaultWorkTime = 25
    private static let defaultShortTime = 5
    private static let defaultLongTime = 15
    private var startOnNext: Bool
    private var maxNum: Int
    private var workCycles: Int
    private var workTime: Int
    private var shortTime: Int
    private var longTime: Int
    @Published var active: Bool
    @Published var mode: TimerMode
    @Published var timeRemaining: Int
    @Published var timer : Timer?
    @Published var selectedMode: String?
    
    init(){
        self.workTime = PomodoroTimerController.defaultWorkTime
        self.shortTime = PomodoroTimerController.defaultShortTime
        self.longTime = PomodoroTimerController.defaultLongTime
        self.mode = .work
        self.timeRemaining = self.workTime * PomodoroTimerController.minutes
        self.active = false
        self.workCycles = 1
        self.startOnNext = false
        self.maxNum = 50
        selectedMode = "work"
    }
    
    func startStop(){
        if self.active {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer(){
        self.active = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else{ return }
            if(self.timeRemaining > 0){
                self.timeRemaining -= 1
            } else {
                self.startNextMode()
            }
        }
    }
    
    func pauseTimer(){
        self.active = false
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func resetTimer(){
        self.pauseTimer()
        self.active = false
        if(self.mode == .work){
            self.timeRemaining = self.workTime * PomodoroTimerController.minutes
        } else if(self.mode == .shortBreak){
            self.timeRemaining = self.shortTime * PomodoroTimerController.minutes
        } else{
            self.timeRemaining = self.longTime * PomodoroTimerController.minutes
        }
        if(self.startOnNext){
            self.startTimer()
        }
    }
    
    func startWork(method: String){
        self.pauseTimer()
        self.mode = .work
        self.timeRemaining = self.workTime * PomodoroTimerController.minutes
        if(method == "next"){
            if(self.workCycles >= 4){
                self.workCycles = 1;
            } else{
                self.workCycles += 1
            }
        } else{
            self.workCycles = 1;
        }
        if(self.startOnNext){
            self.startTimer()
        }
    }
    
    func startShortBreak(method: String){
        self.pauseTimer()
        self.mode = .shortBreak
        self.timeRemaining = self.shortTime * PomodoroTimerController.minutes
        if(method != "next"){
            self.workCycles = 1;
        }
        if(self.startOnNext){
            self.startTimer()
        }
    }
    
    func startLongBreak(method: String){
        self.pauseTimer()
        self.mode = .longBreak
        self.timeRemaining = self.longTime * PomodoroTimerController.minutes
        if(method != "next"){
            self.workCycles = 1;
        }
        if(self.startOnNext){
            self.startTimer()
        }
    }
    
    func startNextMode(){
        if(self.mode == .longBreak || self.mode == .shortBreak){
            self.startWork(method: "next")
        } else if((self.mode == .work) && (self.workCycles % PomodoroTimerController.maxCycles != 0)){
            self.startShortBreak(method: "next")
        } else{
            self.startLongBreak(method: "next")
        }
    }
    
    func getTimeRemaining() -> String {
        let mins = self.timeRemaining / PomodoroTimerController.minutes
        let secs = self.timeRemaining % PomodoroTimerController.minutes
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func setTime(){
        self.pauseTimer()
        self.workCycles = 1;
        switch self.mode {
        case .work:
            self.timeRemaining = self.workTime * PomodoroTimerController.minutes
        case .shortBreak:
            self.timeRemaining = self.shortTime * PomodoroTimerController.minutes
        case .longBreak:
            self.timeRemaining = self.longTime * PomodoroTimerController.minutes
        }
    }
    
    func updateWorkTime(newTime: Int){
        if(newTime < 0){
            self.workTime = self.maxNum
        } else if(newTime > self.maxNum){
            self.workTime = 0
        } else{
            self.workTime = newTime
        }
    }
    
    func updateShortTime(newTime: Int){
        if(newTime < 0){
            self.shortTime = self.maxNum
        } else if(newTime > self.maxNum){
            self.shortTime = 0
        } else{
            self.shortTime = newTime
        }
    }
    
    func updateLongTime(newTime: Int){
        if(newTime < 0){
            self.longTime = self.maxNum
        } else if(newTime > self.maxNum){
            self.longTime = 0
        } else{
            self.longTime = newTime
        }
    }
    
    func getMode(timerType: String) -> String {
        if(timerType == "work"){
            return "Pomodoro"
        } else if(timerType == "shortBreak"){
            return "Short Break"
        } else if(timerType == "longBreak"){
            return "Long Break"
        } else{
            if(self.mode == .work){
                return "Pomodoro"
            } else if(self.mode == .shortBreak){
                return "Short Break"
            } else{
                return "Long Break"
            }
        }
    }
    
    func getWorkCycles() -> Int {
        return self.workCycles
    }
    
    func getWorkTime() -> Int {
        return self.workTime
    }
    
    func getShortTime() -> Int {
        return self.shortTime
    }
    
    func getLongTime() -> Int {
        return self.longTime
    }
    
    func getDefaultWorkTime() -> Int {
        return PomodoroTimerController.defaultWorkTime
    }
    
    func getDefaultShortTime() -> Int {
        return PomodoroTimerController.defaultShortTime
    }
    
    func getDefaultLongTime() -> Int {
        return PomodoroTimerController.defaultLongTime
    }
    
    func getSelectedMode() -> String? {
        return self.selectedMode
    }
    
    func setSelectedMode(method: String){
        self.selectedMode = method
    }
}
