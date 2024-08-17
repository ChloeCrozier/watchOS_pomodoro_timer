// The timing logic behind the pomodoro timer modes

import Foundation

enum TimerMode {
    case work
    case shortBreak
    case longBreak
}

class PomodoroTimer: ObservableObject {
    static let minutes = 60
    @Published var active: Bool
    @Published var mode: TimerMode
    @Published var timeRemaining: Int
    @Published var workCycles: Int
    var timer : Timer?
    
    init(){
        self.timeRemaining = 25 * PomodoroTimer.minutes
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
            self.timeRemaining = 25 * PomodoroTimer.minutes
        } else if(self.mode == .shortBreak){
            self.timeRemaining = 5 * PomodoroTimer.minutes
        } else{
            self.timeRemaining = 15 * PomodoroTimer.minutes
        }
        self.active = false
    }
    
    func startNextMode(){
        if(self.mode == .longBreak || self.mode == .shortBreak){
            self.mode = .work
            self.timeRemaining = 25 * PomodoroTimer.minutes
            self.workCycles += 1
        } else if(self.mode == .work && self.workCycles < 4){
            self.mode = .shortBreak
            self.timeRemaining = 5 * PomodoroTimer.minutes
        } else{
            self.mode = .longBreak
            self.timeRemaining = 15 * PomodoroTimer.minutes
        }
    }
    
    func getWorkCycles() -> Int {
        return self.workCycles
    }
    
    func getTimeRemaining() -> String {
        let mins = self.timeRemaining / 60
        let secs = self.timeRemaining % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}
