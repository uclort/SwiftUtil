//
//  HmViewExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit

/// 可复用协议
protocol Reusable: class {
    /// 复用的id
    static var identifier: String { get }
}

extension Reusable where Self: UIView {
    static var identifier: String {
        NSStringFromClass(self)
    }
}

extension UICollectionViewCell: Reusable {}

extension UITableViewCell: Reusable {}

extension UITableViewHeaderFooterView: Reusable {}

extension UIView {
    
    /// 水平抗拉伸or压缩
    func setHorizontalTelescopicHigh() {
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    /// 垂直抗拉伸
    func setVerticalTelescopicHigh() {
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    /// 转化为 UIImage
    func makeImageWithView(_ opaque: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func removeAllSubviews() {
        while subviews.count > 0 {
            subviews.last?.removeFromSuperview()
        }
    }
    
}

// MARK: 坐标尺寸相关
extension UIView {
    
    /// 控件尺寸
    var size: CGSize {
        get {
            frame.size
        }
        set(newSize) {
            frame.size = CGSize(width: newSize.width, height: newSize.height)
        }
    }
    
    /// 控件宽
    var width: CGFloat {
        get {
            frame.size.width
        }
        set(newWidth) {
            frame.size = CGSize(width: newWidth, height: height)
        }
    }
    
    /// 控件高
    var height: CGFloat {
        get {
            frame.size.height
        }
        set(newHeight) {
            frame.size = CGSize(width: width, height: newHeight)
        }
    }
    
    /// 控件左边距
    var left: CGFloat {
        get {
            frame.origin.x
        }
        set(newLeft) {
            frame = CGRect(x: newLeft, y: top, width: width, height: height)
        }
    }
    
    /// 控件右边距
    var right: CGFloat {
        get {
            left + width
        }
        set(newRight) {
            left = (newRight - width)
        }
    }
    
    /// 控件上边距
    var top: CGFloat {
        get {
            frame.origin.y
        }
        set(newTop) {
            frame = CGRect(x: left, y: newTop, width: width, height: height)
        }
    }
    
    /// 控件底边距
    var bottom: CGFloat {
        get {
            top + height
        }
        set(newBottom) {
            top = (newBottom - height)
        }
    }
    
    /// 控件相对父视图中心 X 轴
    var centerX: CGFloat {
        get {
            center.x
        }
        set(newCenterX) {
            center.x = newCenterX
        }
    }
    
    /// 控件相对父视图中心 Y 轴
    var centerY: CGFloat {
        get {
            center.y
        }
        set(newCenterY) {
            center.y = newCenterY
        }
    }
    
    /// 控件相对父视图坐标
    var origin: CGPoint {
        get {
            frame.origin
        }
        set(newOrigin) {
            frame.origin = newOrigin
        }
    }
    
    /// 控件自身坐标轴中心点
    var middle: CGPoint {
        get {
            CGPoint(x: (width * 0.5), y: (height * 0.5))
        }
    }
    
    /// 控件自身坐标轴 X 轴
    var middleX: CGFloat {
        get {
            width * 0.5
        }
    }
    
    /// 控件自身坐标轴 Y 轴
    var middleY: CGFloat {
        get {
            height * 0.5
        }
    }
}

// MARK: UI 相关
extension UIView {
    
    /// 边线颜色
    var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            if let newValue = newValue {
                layer.borderColor = newValue.cgColor
            }
        }
    }
    
    /// 边线宽
    var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// 圆角值
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// 阴影颜色
    var shadowColor: UIColor? {
        get {
            guard let shadowColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: shadowColor)
        }
        set {
            if let newValue = newValue {
                layer.shadowColor = newValue.cgColor
            }
        }
    }
    
    /// 阴影透明度
    var shadowOpacity: Float {
        get {
            layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// 阴影偏移量
    var shadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// 阴影半径
    var shadowRadius: CGFloat {
        get {
            layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

extension UIView {
    @discardableResult
    func backgroundColor(color: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
}
