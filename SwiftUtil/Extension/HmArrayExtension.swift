//
//  HmArrayExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation

extension Array {
    var hm_lastIndex: Int {
        guard count > 0 else {
            return 0
        }
        return count - 1
    }

    func objectFrom(index: Int) -> Element? {
        guard case 0 ..< count = index else {
            return nil
        }
        return self[index]
    }

    @discardableResult
    func compactMapCustom<T>(_ body: (Element, Int) -> T?) -> [T] {
        var newItemGroup: [T] = []
        hm_forEach { value in
            guard let newItem = body(value.value, value.index) else {
                return
            }
            newItemGroup.append(newItem)
        }
        return newItemGroup
    }
}

extension Array { // 遍历
    struct HmValue {
        var value: Element
        var index: Int
        var isFirst: Bool
        var isLast: Bool
        var stop: (Bool) -> Void
    }

    func hm_forEach(_ body: (_ value: HmValue) -> Void) {
        for (idx, item) in self.enumerated() {
            var isStop: Bool = false
            let value = HmValue(
                value: item,
                index: idx,
                isFirst: idx == 0,
                isLast: idx == self.hm_lastIndex) { stop in
                    isStop = stop
            }
            body(value)
            if isStop {
                return
            }
        }
    }
}
