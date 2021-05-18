//
//  HmToolFunc.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/8.
//

import UIKit
import Foundation

func dPrint(_ any : Any?) {
    #if DEBUG
    if let any = any {
        print(any)
    }
    #endif
}

func Image(imageName: String) -> UIImage? {
    UIImage(named: imageName)
}

func ImageSystem(imageName: String) -> UIImage? {
    UIImage(systemName: imageName)
}

func Font(size: CGFloat, bold: Bool = false) -> UIFont {
    if bold {
        return UIFont.boldSystemFont(ofSize: size)
    }
    return UIFont.systemFont(ofSize: size)
}

