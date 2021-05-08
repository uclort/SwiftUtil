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
    guard let image = UIImage(named: imageName) else {
        return nil
    }
    return image
}

func ImageSystem(imageName: String) -> UIImage? {
    guard let image = UIImage(systemName: imageName) else {
        return nil
    }
    return image
}

func Font(size: CGFloat, bold: Bool = false) -> UIFont {
    if bold {
        return UIFont.boldSystemFont(ofSize: size)
    }
    return UIFont.systemFont(ofSize: size)
}

