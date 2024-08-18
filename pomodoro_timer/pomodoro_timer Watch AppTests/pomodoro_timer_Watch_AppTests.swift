// Test cases for the timer logic
import XCTest
@testable import pomodoro_timer_Watch_App

final class pomodoro_timer_Watch_AppTests: XCTestCase {
    func testInitialization() throws {
        let timer = PomodoroTimer()
        XCTAssertEqual(timer.timeRemaining, 25*60)
        XCTAssertEqual(timer.mode, .work)
        XCTAssertFalse(timer.active)
        XCTAssertEqual(timer.getWorkCycles(), 0)
    }
    
    func testStartStop() throws {
        let timer = PomodoroTimer()
        timer.startStop()
        XCTAssertTrue(timer.active)
        timer.startStop()
        XCTAssertFalse(timer.active)
    }
    
    func testGetTimeRemaining() throws {
        let timer = PomodoroTimer()
        timer.timeRemaining = 75
        XCTAssertEqual(timer.getTimeRemaining(), "01:15")
    }
    
    func testTimerActiveState() throws {
        let timer = PomodoroTimer()
        timer.startStop()
        XCTAssertTrue(timer.active)
        timer.startStop()
        XCTAssertFalse(timer.active)
        timer.startStop()
        XCTAssertTrue(timer.active)
    }
}
