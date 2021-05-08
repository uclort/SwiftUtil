//
//  HmNumberExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit
import Foundation

extension Int {
    var stringValue: String {
        "\(self)"
    }
    var doubleValue: Double {
        Double(self)
    }
    var boolValue: Bool {
        self > 0
    }
    var timeIntervalValue: TimeInterval {
        TimeInterval(self)
    }
    var cgFloatValue: CGFloat {
        CGFloat(self)
    }
    
    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date {
        Date(timeIntervalSince1970: timeIntervalValue)
    }
    
    /// 转成 Date 字符串
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String {
        let dateFormatter = DateFormatter()
        var dateFormat = ""
        switch type {
        case .custom(let format):
            dateFormat = format
        default:
            dateFormat = type.rawValue
        }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: toDate())
    }
    
}

extension Int64 {
    var stringValue: String {
        "\(self)"
    }
    var boolValue: Bool {
        self != 0
    }
    var timeIntervalValue: TimeInterval {
        TimeInterval(self)
    }
    var intValue: Int {
        Int(self)
    }
    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date {
        intValue.toDate()
    }
    
    /// 转成 Date 字符串
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String {
        intValue.toDateString(type: type)
    }
}

extension Float {
    var stringValue: String {
        "\(self)"
    }
    var intValue: Int {
        Int(self)
    }
    var cgFloatValue: CGFloat {
        CGFloat(self)
    }
}

extension Double {
    var stringValue: String {
        "\(self)"
    }
    var intValue: Int {
        Int(self)
    }
    var cgFloatValue: CGFloat {
        CGFloat(self)
    }
}

extension TimeInterval {
    
    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date {
        intValue.toDate()
    }
    
    /// 转成 Date 字符串
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String {
        intValue.toDateString(type: type)
    }
}
