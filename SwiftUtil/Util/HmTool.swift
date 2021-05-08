//
//  HmTool.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/8.
//

import UIKit
import Foundation


class Tool {
    
    static let shared = Tool()
    
    func openUrl(to url: URL?) {
        guard let url = url else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openSetting() {
        openUrl(to: URL(string: UIApplication.openSettingsURLString))
    }
    
    /// 收起键盘
    func HideKeyBoard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}
