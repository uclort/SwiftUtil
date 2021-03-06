//
//  HmDictionaryExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

extension Dictionary where Key == String {
    
    func hm_stringForKey(_ key: String) -> String? {
        let value = self[key]
        if let valueInt64 = value as? Int64 { // 是整型
            return valueInt64.stringValue
        } else if let valueInt = value as? Int {  // 是整型
            return valueInt.stringValue
        } else if let valueDouble = value as? Double { // 是浮点型
            return valueDouble.stringValue
        } else if let valueString = value as? String {
            return valueString
        }
        return nil
    }
    
    func hm_dictionaryForKey(_ key: String) -> [String: Any]? {
        self[key] as? [String: Any]
    }
    
    func hm_floatForKey(_ key: String) -> Double? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt.doubleValue
        } else if let valueFloat = value as? Double { // 是浮点型
            return valueFloat
        } else if let valueString = value as? String {
            return valueString.doubleValue
        }
        return nil
    }
    
    func hm_intForKey(_ key: String) -> Int? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt
        } else if let valueFloat = value as? Double { // 是浮点型
            return valueFloat.intValue
        } else if let valueString = value as? String {
            return valueString.intValue
        }
        return nil
    }
    
    func hm_boolForKey(_ key: String) -> Bool? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt > 0
        } else if let valueBool = value as? Bool {
            return valueBool
        } else if let valueString = value as? String {
            return valueString.boolValue
        }
        return nil
    }
    
    func merge(_ otherDictionary: [String: Any]?) -> [String: Any] {
        guard let otherDictionary = otherDictionary else {
            return self
        }
        var newDictionary: [String: Any] = [:]
        for item in self {
            newDictionary[item.key] = item.value
        }
        for item in otherDictionary {
            newDictionary[item.key] = item.value
        }
        return newDictionary
    }
    
    func toJsonString(pretty: Bool = true, sort: Bool = false) -> String? {
        var options: JSONSerialization.WritingOptions = []
        if pretty {
            options.insert(.prettyPrinted)
        }
        if sort {
            options.insert(.sortedKeys)
        }
        guard JSONSerialization.isValidJSONObject(self), let data = try? JSONSerialization.data(withJSONObject: self, options: options) else {
            return nil
        }
        return String(data:data, encoding: String.Encoding.utf8)
    }
}
