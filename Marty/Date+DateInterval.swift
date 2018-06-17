//
//  Date+DateInterval.swift
//  Marty
//
//  Created by eliksir on 17/06/2018.
//  Copyright © 2018 eliksir. All rights reserved.
//

import Foundation

public extension Date {
    
    static var now: Date {
        return Date()
    }
    public static var yesterday: Date {
        return 1.days.ago
    }
    
    public static var tomorrow: Date {
        return 1.days.fromNow
    }
    
    public var theDayBefore: Date {
        return 1.days.before(self)
    }
    
    public var theDayAfter: Date {
        return 1.days.after(self)
    }
    
    public static func + (left: Date, right: DateInterval) -> Date {
        return right.after(left)
    }
    
    public static func - (left: Date, right: DateInterval) -> Date {
        return right.before(left)
    }
}

public struct DateInterval {
    private typealias Interval = (unit: Calendar.Component, value: Int)
    private var intervals: [Interval] = []
    
    init() {
    }
    
    init(unit: Calendar.Component, value: Int) {
        intervals.append(Interval(unit: unit, value: value))
    }
    
    public var ago: Date {
        return intervalDate(negative: true)
    }
    
    public var fromNow: Date {
        return intervalDate(negative: false)
    }
    
    public func after(_ date: Date) -> Date {
        return intervalDate(negative: false, fromDate: date)
    }
    
    public func before(_ date: Date) -> Date {
        return intervalDate(negative: true, fromDate: date)
    }
    
    private func intervalDate(negative: Bool, fromDate originDate: Date? = nil) -> Date {
        var date = originDate ?? Date.now
        intervals.forEach { (interval: Interval) in
            date = Calendar.current.date(byAdding: interval.unit, value: negative ? -interval.value:interval.value, to: date)!
        }
        
        return date
    }
    
    mutating private func addIntervals(from otherDateInterval: DateInterval, negative: Bool = false) {
        if !negative {
            intervals += otherDateInterval.intervals
        } else {
            let negativeIntervals = otherDateInterval.intervals.map({ (interval: (unit: Calendar.Component, value: Int)) -> Interval in
                return Interval(unit: interval.unit, value: -interval.value)
            })
            
            intervals += negativeIntervals
        }
    }
    
    static func + (left: DateInterval, right: DateInterval) -> DateInterval {
        var dateInterval = DateInterval()
        dateInterval.addIntervals(from: left)
        dateInterval.addIntervals(from: right)
        return dateInterval
    }
    
    static func - (left: DateInterval, right: DateInterval) -> DateInterval {
        var dateInterval = DateInterval()
        dateInterval.addIntervals(from: left)
        dateInterval.addIntervals(from: right, negative: true)
        return dateInterval
    }
}

public extension Int {
    var years: DateInterval {
        return DateInterval(unit: .year, value: self)
    }
    
    var months: DateInterval {
        return DateInterval(unit: .month, value: self)
    }
    
    var weeks: DateInterval {
        return DateInterval(unit: .weekOfYear, value: self)
    }
    
    var days: DateInterval {
        return DateInterval(unit: .day, value: self)
    }
    
    var hours: DateInterval {
        return DateInterval(unit: .hour, value: self)
    }
    
    var minutes: DateInterval {
        return DateInterval(unit: .minute, value: self)
    }
    
    var seconds: DateInterval {
        return DateInterval(unit: .second, value: self)
    }
}
