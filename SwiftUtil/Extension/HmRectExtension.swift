//
//  HmRectExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/8.
//

import UIKit

extension CGRect {
    
    var top: CGFloat {
        get {
            origin.y
        }
        set(newY) {
            origin.y = newY
        }
    }
    var left: CGFloat {
        get {
            origin.x
        }
        set(newX) {
            origin.x = newX
        }
    }
    var bottom: CGFloat {
        get {
            top + height
        }
        set(newBottom) {
            top = (newBottom - height)
        }
    }
    var right: CGFloat {
        get {
            left + width
        }
        set(newRight) {
            left = (newRight - width)
        }
    }
    var center: CGPoint {
        get {
            CGPoint(x: left + width * 0.5, y: top + height * 0.5)
        }
        set(newCenter) {
            origin = CGPoint(x: left + (newCenter.x - centerX), y: top + (newCenter.y - centerY))
        }
    }
    var centerX: CGFloat {
        get {
            center.x
        }
        set(newCenterX) {
            origin.x = left + (newCenterX - centerX)
        }
    }
    var centerY: CGFloat {
        get {
            center.y
        }
        set(newCenterY) {
            origin.x = top + (newCenterY - centerY)
        }
    }
    var middle: CGPoint {
        get {
            CGPoint(x: (width * 0.5), y: (height * 0.5))
        }
    }
    var middleX: CGFloat {
        get {
            width * 0.5
        }
    }
    var middleY: CGFloat {
        get {
            height * 0.5
        }
    }
}
