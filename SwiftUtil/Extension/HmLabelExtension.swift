//
//  HmLabelExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/6/7.
//

import UIKit
import Foundation

extension UILabel {
    @discardableResult
    func font(size: CGFloat) -> UILabel {
        font = UIFont.systemFont(ofSize: size)
        return self
    }
    
    @discardableResult
    func boldFont(size: CGFloat) -> UILabel {
        font = UIFont.boldSystemFont(ofSize: size)
        return self
    }
    
    
}
