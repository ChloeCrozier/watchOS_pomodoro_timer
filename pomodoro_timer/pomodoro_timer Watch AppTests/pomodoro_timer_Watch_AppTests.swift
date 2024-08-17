//
//  pomodoro_timer_Watch_AppTests.swift
//  pomodoro_timer Watch AppTests
//
//  Created by Chloe Crozier on 8/16/24.
//

import XCTest
@testable import pomodoro_timer_Watch_App

final class pomodoro_timer_Watch_AppTests: XCTestCase {

//    override func setUpWithError() throws {
//    }

//    override func tearDownWithError() throws {
//    }

    func testInitialization() throws {
        let timer = PomodoroTimer()
        XCTAssertEqual(timer.timeRemaining, 25*60)
        XCTAssertEqual(timer.mode, .work)
        XCTAssertFalse(timer.active)
        XCTAssertEqual(timer.workCycles, 0)
    }
    
    func testStartStop() throws {
        let timer = PomodoroTimer()
        timer.startStop()
        XCTAssertTrue(timer.active)
        timer.startStop()
        XCTAssertFalse(timer.active)
    }
    
    func testModeTransitions() throws {
        let timer = PomodoroTimer()
        
        // Test transition from work to short break
        timer.mode = .work
        timer.workCycles = 3
        timer.startNextMode()
        XCTAssertEqual(timer.mode, .shortBreak)
        XCTAssertEqual(timer.timeRemaining, 5*PomodoroTimer.minutes)
        
        // Test transition from short break to long break
        timer.mode = .work
        timer.workCycles = 4
        timer.startNextMode()
        XCTAssertEqual(timer.mode, .longBreak)
        XCTAssertEqual(timer.timeRemaining, 15*PomodoroTimer.minutes)
    }

    
    func testGetTimeRemaining() throws {
        let timer = PomodoroTimer()
        timer.timeRemaining = 75
    }

//    func testPerformanceExample() throws {
//        self.measure {
//        }
//    }
}
