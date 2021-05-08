//
//  ViewController.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .hexString("#7e2065", alpha: 0.6)
//        
//        HmDispatch.childThread {
//            print(Thread.current)
//            HmDispatch.mainThread {
//                print(Thread.current)
//            }
//        }
//        
//        HmDispatch.asyncDelay(3) {
//            print("异步任务")
//        } mainTask: {
//            print("异步任务完成")
//        }

        
    }


}

