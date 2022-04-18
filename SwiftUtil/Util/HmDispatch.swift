//
//  HmDispatch.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation
import UIKit

public typealias HmTask = () -> Void

public class HmDispatch {
    @discardableResult
    public static func delay(_ seconds: Double, _ action: @escaping HmTask) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: workItem)
        return workItem
    }
    
    // MARK: 异步延迟
    @discardableResult
    public static func asyncDelay(_ seconds: Double, task: @escaping HmTask, mainHmTask: HmTask? = nil) -> DispatchWorkItem {
        _asyncDelay(seconds, task, mainHmTask)
    }

    private static func _asyncDelay(_ seconds: Double, _ task: @escaping HmTask, _ mainHmTask: HmTask?) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: workItem)
        if let mainHmTask = mainHmTask {
            workItem.notify(queue: DispatchQueue.main, execute: mainHmTask)
        }
        return workItem
    }
    
    /// 子线程
    public static func childThread(_ handler: @escaping () -> Void) {
        DispatchQueue.global().async(execute: handler)
    }
    
    /// 主线程
    public static func mainThread(_ handler: @escaping () -> Void) {
        DispatchQueue.main.async(execute: handler)
    }
    
}

