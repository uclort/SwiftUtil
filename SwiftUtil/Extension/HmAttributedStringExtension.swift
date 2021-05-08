//
//  HmAttributedStringExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit

extension NSMutableAttributedString {
    
    func addAttributeColor(_ color: UIColor, rangeString: String) {
        self.addAttribute(.foregroundColor, value: color, range: range(of: rangeString))
    }
    
    func addAttributeFont(_ font: UIFont, rangeString: String) {
        self.addAttribute(.font, value: font, range: range(of: rangeString))
    }
    
    func addAttribute(_ attrs: [NSAttributedString.Key : Any], rangeString: String) {
        self.addAttributes(attrs, range: range(of: rangeString))
    }
    
    func range(of string: String = "") -> NSRange {
        return self.string.range(of: string)
    }
    
}
