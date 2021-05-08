//
//  HmDateExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

extension Date {
    
    /// 格式化类型
    enum DateFormatterType {
        
        /// 1970-01-01 12:00:12 -> 1970-01-01
        case year_month_day
        /// 1970-01-01 12:00:12 -> 12:00:00
        case hour_minute_second
        /// 1970-01-01 12:00:12 -> 1970-01-01 12:00:12
        case year_month_day_hour_minute_second
        /// Custom Format String
        case custom(String)
        
        var rawValue: String {
            switch self {
            case .year_month_day:
                return "yyyy-MM-dd"
            case .hour_minute_second:
                return "HH:mm:ss"
            case .year_month_day_hour_minute_second:
                return "yyyy-MM-dd HH:mm:ss"
            case .custom(_):
                return "custom"
            }
        }
        
    }
    
    /// 是否为今天
    /// - Returns: true 则为今天
    func isToday() -> Bool {
        let calendar = NSCalendar.current
        return calendar.isDateInToday(self)
    }
    
    /// 是否为昨天
    /// - Returns: true 则为昨天
    func isYesterday() -> Bool {
        let calendar = NSCalendar.current
        return calendar.isDateInYesterday(self)
    }
    
    /// 是否为明天
    /// - Returns: true 则为明天
    func isTomorrow() -> Bool {
        let calendar = NSCalendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    /// 是否为周末
    /// - Returns: true 则为周末
    func isWeekend() -> Bool {
        let calendar = NSCalendar.current
        return calendar.isDateInWeekend(self)
    }
    
    /// 格式化为指定格式
    func format(type: DateFormatterType = .year_month_day) -> String {
        let formatter = DateFormatter()
        var dateFormat = ""
        switch type {
        case .custom(let format):
            dateFormat = format
        default:
            dateFormat = type.rawValue
        }
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    func timeInterval() -> TimeInterval {
        return self.timeIntervalSince1970
    }
}
