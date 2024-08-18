// The timing logic behind the pomodoro timer modes
import Foundation

enum TimerMode {
    case work
    case shortBreak
    case longBreak
}

class PomodoroTimer: ObservableObject {
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
    
    init(){
        self.workTime = 1
        self.shortTime = 2
        self.longTime = 3
        self.mode = .work
        self.timeRemaining = self.workTime * PomodoroTimer.minutes
        self.active = false
        self.workCycles = 1
        self.startOnNext = false
        self.maxNum = 50
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
        self.pauseTimer()
        self.active = false
        if(self.mode == .work){
            self.timeRemaining = self.workTime * PomodoroTimer.minutes
        } else if(self.mode == .shortBreak){
            self.timeRemaining = self.shortTime * PomodoroTimer.minutes
        } else{
            self.timeRemaining = self.longTime * PomodoroTimer.minutes
        }
        if(self.startOnNext){
            self.startTimer()
        }
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
            self.timeRemaining = self.shortTime * PomodoroTimer.minutes
        case .longBreak:
            self.timeRemaining = self.longTime * PomodoroTimer.minutes
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
    
    func getTimerIcon(modeType: String) -> String {
        switch modeType {
        case "work":
            if self.workTime < 10 {
                return "0\(self.workTime).circle.fill"
            } else {
                return "\(self.workTime).circle.fill"
            }
        case "shortBreak":
            if self.shortTime < 10 {
                return "0\(self.shortTime).circle.fill"
            } else {
                return "\(self.shortTime).circle.fill"
            }
        case "longBreak":
            if self.longTime < 10 {
                return "0\(self.longTime).circle.fill"
            } else {
                return "\(self.longTime).circle.fill"
            }
        default:
            return ""
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
        return PomodoroTimer.defaultWorkTime
    }
    
    func getDefaultShortTime() -> Int {
        return PomodoroTimer.defaultShortTime
    }
    
    func getDefaultLongTime() -> Int {
        return PomodoroTimer.defaultLongTime
    }
}
