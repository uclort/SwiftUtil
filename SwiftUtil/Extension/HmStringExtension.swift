//
//  HmStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

extension String {
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        removingPercentEncoding ?? ""
    }
    
    /// 从开始截取字符串
    func intercept_prefix(_ maxLength: Int) -> String {
        if maxLength > count {
            return String(prefix(count))
        }
        return String(prefix(maxLength))
    }
    
    /// 从结尾截取字符串
    func intercept_suffix(_ maxLength: Int) -> String {
        if maxLength > count {
            return String(suffix(count))
        }
        return String(suffix(maxLength))
    }
    
    func range(of string: String = "") -> NSRange {
        let nsstring = self as NSString
        guard string.isEmpty == false else {
            return nsstring.range(of: self)
        }
        return nsstring.range(of: string)
    }
    
    // 替换字符串中的内容
    func replace(of: String, with: String) -> String {
        replacingOccurrences(of: of, with: with)
    }
    
    /// 解析 URL 获取 URL 所携带参数
    /// - Returns: URL 携带参数集合
    func getUrlParameter() -> [String: Any] {
        var parameters: [String: Any] = [:]
        guard let url = URL(string: self) else {
            return parameters
        }
        guard let parametersString = url.query else {
            return parameters
        }
        let parametersGroup = parametersString.components(separatedBy: "&")
        parametersGroup.forEach { itemString in
            let itemKeyValue = itemString.components(separatedBy: "=")
            let key = itemKeyValue.first ?? ""
            var value = itemKeyValue.last ?? ""
            for (idx, item) in itemKeyValue.enumerated() {
                guard idx > 1 else {
                    continue
                }
                value = "\(value)=\(item)"
            }
            parameters[key.urlDecoded()] = value.urlDecoded()
        }
        return parameters
    }
    
    /// 本地化字符内容
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }
    
    /// 转成 NSNumber
    func toNumber() -> NSNumber? {
        NumberFormatter().number(from: self)
    }
    
    /// 转成 Date
    func toDate(type: Date.DateFormatterType = .year_month_day) -> Date? {
        let dateFormatter = DateFormatter()
        var dateFormat = ""
        switch type {
        case .custom(let format):
            dateFormat = format
        default:
            dateFormat = type.rawValue
        }
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
    
    func toDateString(type: Date.DateFormatterType = .year_month_day) -> String? {
        timeIntervalValue?.toDateString(type: type)
    }
}

extension String { // Type Conversion
    
    var intValue: Int? {
        toNumber()?.intValue
    }
    
    var doubleValue: Double? {
        toNumber()?.doubleValue
    }
    
    var floatValue: Float? {
        toNumber()?.floatValue
    }
    
    var timeIntervalValue: TimeInterval? {
        toNumber()?.doubleValue
    }
    
    var boolValue: Bool {
        self == "true"
    }
    
}
