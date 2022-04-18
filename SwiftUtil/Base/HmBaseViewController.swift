//
//  HmBaseViewController.swift
//  Example
//
//  Created by mfhj-dz-001-059 on 2021/6/22.
//

import UIKit

class HmBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        initializeAttribute()
        addCustomControl()
        setupCustomControlStyle()
        addCustomConstraint()
        bindHandler()
        sendHandler()
    }
    
    /// 初始化 View 样式
    func initializeView() {
        view.backgroundColor = .systemBackground
    }
    
    /// 初始化成员属性
    func initializeAttribute() {}
    
    /// 添加自定义控件
    func addCustomControl() {}
    
    /// 设置自定义控件样式
    func setupCustomControlStyle() {}
    
    /// 添加约束
    func addCustomConstraint() {}
    
    /// 绑定 处理
    func bindHandler() {}
    
    /// 发送 处理
    func sendHandler() {}

}
