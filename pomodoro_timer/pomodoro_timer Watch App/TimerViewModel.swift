// The model that connects the view and the controller
import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var timer = PomodoroTimer()
    
    var backgroundColor: Color {
        switch timer.mode {
        case .work:
            return Color.red
        case .shortBreak:
            return Color.green
        case .longBreak:
            return Color.blue
        }
    }
}
