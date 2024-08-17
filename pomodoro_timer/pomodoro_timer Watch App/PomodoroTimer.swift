// The timing logic behind the pomodoro timer modes

import Foundation

enum TimerMode {
    case work
    case shortBreak
    case longBreak
}

class PomodoroTimer: ObservableObject {
    static let minutes = 60
    static let workTime = 1
    static let shortTime = 1
    static let longTime = 1
    static let maxCycles = 4
    @Published var active: Bool
    @Published var mode: TimerMode
    @Published var timeRemaining: Int
    @Published var workCycles: Int
    var timer : Timer?
    
    init(){
        self.timeRemaining = PomodoroTimer.workTime * PomodoroTimer.minutes
        self.mode = .work
        self.active = false
        self.workCycles = 0
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
                print("Time Remaining: \(self.timeRemaining)")
            } else {
                self.pauseTimer()
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
        if(self.mode == .work){
            self.timeRemaining = PomodoroTimer.workTime * PomodoroTimer.minutes
        } else if(self.mode == .shortBreak){
            self.timeRemaining = PomodoroTimer.shortTime * PomodoroTimer.minutes
        } else{
            self.timeRemaining = PomodoroTimer.longTime * PomodoroTimer.minutes
        }
        self.active = false
    }
    
    func startNextMode(){
        if(self.mode == .longBreak || self.mode == .shortBreak){
            self.mode = .work
            self.timeRemaining = PomodoroTimer.workTime * PomodoroTimer.minutes
            self.workCycles += 1
        } else if(self.mode == .work && self.workCycles < PomodoroTimer.maxCycles){
            self.mode = .shortBreak
            self.timeRemaining = PomodoroTimer.shortTime * PomodoroTimer.minutes
        } else{
            self.mode = .longBreak
            self.timeRemaining = PomodoroTimer.longTime * PomodoroTimer.minutes
        }
    }
    
    func getWorkCycles() -> Int {
        return self.workCycles
    }
    
    func getTimeRemaining() -> String {
        let mins = self.timeRemaining / PomodoroTimer.minutes
        let secs = self.timeRemaining % PomodoroTimer.minutes
        return String(format: "%02d:%02d", mins, secs)
    }
}
