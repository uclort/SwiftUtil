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
        let value = (self[key] as? [String: Any]) ?? [:]
        return value
    }
    
    func hm_floatForKey(_ key: String) -> Double? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt.doubleValue
        } else if let valueFloat = value as? Double { // 是浮点型
            return valueFloat
        } else if let valueString = value as? String {
            return valueString.doubleValue
        } else {
            return nil
        }
    }
    
    func hm_intForKey(_ key: String) -> Int? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt
        } else if let valueFloat = value as? Double { // 是浮点型
            return valueFloat.intValue
        } else if let valueString = value as? String {
            return valueString.intValue
        } else {
            return nil
        }
    }
    
    func hm_boolForKey(_ key: String) -> Bool? {
        let value = self[key]
        if let valueInt = value as? Int { // 是整型
            return valueInt > 0
        } else if let valueBool = value as? Bool {
            return valueBool
        } else if let valueString = value as? String {
            return valueString.boolValue
        } else {
            return nil
        }
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
    
    func toJsonString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("is not a valid json object")
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        let str = String(data:data!, encoding: String.Encoding.utf8)
        return str
    }
}
