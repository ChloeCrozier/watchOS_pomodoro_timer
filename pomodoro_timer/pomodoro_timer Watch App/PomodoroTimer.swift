// The timing logic behind the pomodoro timer modes
import Foundation

enum TimerMode {
    case work
    case shortBreak
    case longBreak
}

class PomodoroTimer: ObservableObject {
    static let minutes = 60
    static let maxCycles = 4
    var startOnNext: Bool
    var workCycles: Int
    var workTime: Int
    var shortTime: Int
    var longTime: Int
    @Published var active: Bool
    @Published var mode: TimerMode
    @Published var timeRemaining: Int
    @Published var timer : Timer?
    
    init(){
        self.workTime = 1
        self.shortTime = 2
        self.longTime = 3
        self.mode = .work
        self.timeRemaining = self.workTime * PomodoroTimer.minutes
        self.active = false
        self.workCycles = 1
        self.startOnNext = false
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
                self.timeRemaining -= 10
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
        if(self.mode == .work){
            self.timeRemaining = self.workTime * PomodoroTimer.minutes
        } else if(self.mode == .shortBreak){
            self.timeRemaining = self.shortTime * PomodoroTimer.minutes
        } else{
            self.timeRemaining = self.longTime * PomodoroTimer.minutes
        }
        self.active = false
    }
    
    func startWork(method: String){
        self.pauseTimer()
        self.mode = .work
        self.timeRemaining = self.workTime * PomodoroTimer.minutes
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
        self.timeRemaining = self.shortTime * PomodoroTimer.minutes
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
        self.timeRemaining = self.longTime * PomodoroTimer.minutes
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
        } else if((self.mode == .work) && (self.workCycles % PomodoroTimer.maxCycles != 0)){
            self.startShortBreak(method: "next")
        } else{
            self.startLongBreak(method: "next")
        }
    }
    
    func getTimeRemaining() -> String {
        let mins = self.timeRemaining / PomodoroTimer.minutes
        let secs = self.timeRemaining % PomodoroTimer.minutes
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func setTime(){
        self.pauseTimer()
        self.workCycles = 1;
        switch self.mode {
        case .work:
            self.timeRemaining = self.workTime * PomodoroTimer.minutes
        case .shortBreak:
            self.timeRemaining = self.workTime * PomodoroTimer.minutes
        case .longBreak:
            self.timeRemaining = self.workTime * PomodoroTimer.minutes
        }
    }
    
    func updateWorkTime(newTime: Int){
        if(newTime < 0){
            self.workTime = 99
        } else if(newTime > 99){
            self.workTime = 0
        } else{
            self.workTime = newTime
        }
    }
    
    func updateShortTime(newTime: Int){
        if(newTime < 0){
            self.shortTime = 99
        } else if(newTime > 99){
            self.shortTime = 0
        } else{
            self.shortTime = newTime
        }
    }
    
    func updateLongTime(newTime: Int){
        if(newTime < 0){
            self.longTime = 99
        } else if(newTime > 99){
            self.longTime = 0
        } else{
            self.longTime = newTime
        }
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
}
