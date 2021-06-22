//
//  HmTextField.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/6/22.
//

import UIKit

class HmTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 0)
    }

}
