//
//  HmAttributedStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit

enum HmAttributedStringKey {
    /// 文字字体
    case font(UIFont)
    /// 文字颜色
    case foregroundColor(UIColor)
}

extension NSMutableAttributedString {
    func gm_addAttribute(_ keys: HmAttributedStringKey..., rangeString: String = "") {
        keys.forEach { key in
            switch key {
            case .font(let value):
                addAttribute(.font, value: value, range: hm_range(of: rangeString))
            case .foregroundColor(let value):
                addAttribute(.foregroundColor, value: value, range: hm_range(of: rangeString))
            }
        }
    }

    func hm_range(of string: String = "") -> NSRange {
        self.string.hm_range(of: string)
    }
}
