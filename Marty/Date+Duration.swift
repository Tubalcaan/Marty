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
    
    public static func + (left: Date, right: Duration) -> Date {
        return right.after(left)
    }
    
    public static func - (left: Date, right: Duration) -> Date {
        return right.before(left)
    }
}

public struct Duration {
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
    
    mutating private func addIntervals(from otherDuration: Duration, negative: Bool = false) {
        if !negative {
            intervals += otherDuration.intervals
        } else {
            let negativeIntervals = otherDuration.intervals.map({ (interval: (unit: Calendar.Component, value: Int)) -> Interval in
                return Interval(unit: interval.unit, value: -interval.value)
            })
            
            intervals += negativeIntervals
        }
    }
    
    static func + (left: Duration, right: Duration) -> Duration {
        var duration = Duration()
        duration.addIntervals(from: left)
        duration.addIntervals(from: right)
        return duration
    }
    
    static func - (left: Duration, right: Duration) -> Duration {
        var duration = Duration()
        duration.addIntervals(from: left)
        duration.addIntervals(from: right, negative: true)
        return duration
    }
}

public extension Duration {
    public var timeInterval: TimeInterval {
        let now = Date.now
        let interval = intervalDate(negative: false, fromDate: now).timeIntervalSince(now)
        return round(1000*interval)/1000
    }
}

extension Duration {
    static prefix func - (duration: Duration) -> Duration {
        var dur = Duration()
        dur.addIntervals(from: duration, negative: true)
        
        return dur
    }
}

extension Duration: CustomStringConvertible {
    public var description: String {
        return timeInterval.description
    }
}

extension Duration: CustomDebugStringConvertible {
    public var debugDescription: String {
        return intervals.map { (unit: Calendar.Component, value: Int) -> String in
            return "\(value) \(unit)"
            }
            .joined(separator: " | ")
    }
}

public extension Int {
    var years: Duration {
        return Duration(unit: .year, value: self)
    }
    
    var months: Duration {
        return Duration(unit: .month, value: self)
    }
    
    var weeks: Duration {
        return Duration(unit: .weekOfYear, value: self)
    }
    
    var days: Duration {
        return Duration(unit: .day, value: self)
    }
    
    var hours: Duration {
        return Duration(unit: .hour, value: self)
    }
    
    var minutes: Duration {
        return Duration(unit: .minute, value: self)
    }
    
    var seconds: Duration {
        return Duration(unit: .second, value: self)
    }
    
    var milliseconds: Duration {
        return Duration(unit: .nanosecond, value: self * 1000000)
    }
}

public extension TimeInterval {
    init(_ duration: Duration) {
        self.init(duration.timeInterval)
    }
}
