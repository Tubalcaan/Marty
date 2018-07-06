//
//  MartyTests.swift
//  MartyTests
//
//  Created by eliksir on 17/06/2018.
//  Copyright © 2018 eliksir. All rights reserved.
//

import XCTest
@testable import Marty

class MartyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUseCases() {
        // Time intervals are not exactly correct, because there is the delay of calculation
        var diff = 24.minutes.ago.timeIntervalSinceNow
        XCTAssert(ceil(diff) == -60*24, "24.minutes.ago is wrong")

        diff = 2.hours.fromNow.timeIntervalSinceNow
        XCTAssert(ceil(diff) == 60*60*2, "2.hours.fromNow is wrong")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: "2018-06-20 09:30")!
        
        let twoDaysBeforeDate = dateFormatter.date(from: "2018-06-18 09:30")!
        XCTAssert(2.days.before(date).timeIntervalSinceReferenceDate == twoDaysBeforeDate.timeIntervalSinceReferenceDate, "2.days.before is wrong")

        let tenMinutesAfterDate = dateFormatter.date(from: "2018-06-20 09:40")!
        XCTAssert(10.minutes.after(date).timeIntervalSinceReferenceDate == tenMinutesAfterDate.timeIntervalSinceReferenceDate, "10.minutes.after is wrong")

        let dateMinusTwoMonths = dateFormatter.date(from: "2018-04-20 09:30")!
        XCTAssert((date - 2.months).timeIntervalSinceReferenceDate == dateMinusTwoMonths.timeIntervalSinceReferenceDate, "date - 2.months is wrong")

        let datePlusSixYears = dateFormatter.date(from: "2024-06-20 09:30")!
        XCTAssert((date + 6.years).timeIntervalSinceReferenceDate == datePlusSixYears.timeIntervalSinceReferenceDate, "date + 6.years is wrong")

        XCTAssert((60.minutes + 18.seconds).timeInterval == 3618, "60.minutes + 18.seconds are wrong")
        XCTAssert(TimeInterval(2.milliseconds) == 0.002, "2.milliseconds are wrong")
        XCTAssert(300.milliseconds.timeInterval == 0.3, "300.milliseconds are wrong")
    }
}
