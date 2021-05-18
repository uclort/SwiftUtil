//
//  HmDispatch.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import Foundation
import UIKit

public typealias Task = () -> Void

public class HmDispatch {
    @discardableResult
    public static func delay(_ seconds: Double, _ action: @escaping Task) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: workItem)
        return workItem
    }
    
    // MARK: 异步延迟
    @discardableResult
    public static func asyncDelay(_ seconds: Double, task: @escaping Task, mainTask: Task? = nil) -> DispatchWorkItem {
        _asyncDelay(seconds, task, mainTask)
    }

    private static func _asyncDelay(_ seconds: Double, _ task: @escaping Task, _ mainTask: Task?) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: workItem)
        if let mainTask = mainTask {
            workItem.notify(queue: DispatchQueue.main, execute: mainTask)
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

