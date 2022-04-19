//
//  await_async.swift
//  SwiftUtil
//
//  Created by 侯猛 on 2022/4/18.
//

import Foundation
import UIKit

class await_async: HmBaseViewController {
    var resultString: String = "" {
        didSet {
            resultLabel.text = resultString
        }
    }

    var resultLabel: UILabel!

    override func addCustomControl() {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }

        let resultLabel = UILabel()
        resultLabel.textAlignment = .center
        resultLabel.textColor = .label
        resultLabel.font = .systemFont(ofSize: 18)
        buttonStackView.addArrangedSubview(resultLabel)
        self.resultLabel = resultLabel

        let button1 = UIButton(type: .custom)
        button1.setTitleColor(.label, for: .normal)
        button1.setTitleColor(.label.alpha(0.6), for: .highlighted)
        button1.setTitle("throws", for: .normal)
        button1.addTarget(self, action: #selector(configUI_throws), for: .touchUpInside)
        buttonStackView.addArrangedSubview(button1)

        let button2 = UIButton(type: .custom)
        button2.setTitleColor(.label, for: .normal)
        button2.setTitleColor(.label.alpha(0.6), for: .highlighted)
        button2.setTitle("no throws", for: .normal)
        button2.addTarget(self, action: #selector(configUI), for: .touchUpInside)
        buttonStackView.addArrangedSubview(button2)
    }
}

// MARK: throws
extension await_async {
    // MARK: 布局 UI
    @objc
    func configUI_throws() {
        resultString = "模拟加载中..."
        Task {
            do {
                resultString = try await getData_throws()
            } catch {
                resultString = (error as NSError).domain
            }
        }
    }

    // MARK: 获取数据
    func getData_throws() async throws -> String {
        do {
            return try await requestData_throws()
        } catch {
            throw error
        }
    }
    
    // MARK: 请求数据前进行并检查
    /// 运行时对 continuation 进行检查是否调用 `resume` 进行返回
    /// 如果不调用会造成资源泄露。多次调用也会造成问题
    func requestData_throws() async throws -> String {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                /// 模拟网络请求异步回调
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    let hasError = Int.random(in: 0 ... 1) == 1
                    if hasError {
                        continuation.resume(throwing: NSError(domain: "hasError -> \(hasError)", code: 0))
                    } else {
                        continuation.resume(returning: "我是结果")
                    }
                }
            }
        } catch {
            throw error
        }
    }
    
    // MARK: 请求数据前不进行检查
    /// 运行时不会对 continuation 进行检查
    /// 比 withCheckedThrowingContinuation 性能好
    /// 先使用 withCheckedThrowingContinuation 测试确认没有问题后正式版可改用 withUnsafeThrowingContinuation
    func requestData_throws_unsafe() async throws -> String {
        do {
            return try await withUnsafeThrowingContinuation { continuation in
                /// 模拟网络请求异步回调
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    let hasError = Int.random(in: 0 ... 1) == 1
                    if hasError {
                        continuation.resume(throwing: NSError(domain: "hasError -> \(hasError)", code: 0))
                    } else {
                        continuation.resume(returning: "我是结果")
                    }
                }
            }
        } catch {
            throw error
        }
    }
}

// MARK: no throws
extension await_async {
    // MARK: 布局 UI
    @objc
    func configUI() {
        resultString = "模拟加载中..."
        Task {
            resultString = await getData()
            debugPrint(resultString)
        }
    }

    // MARK: 获取数据
    func getData() async -> String {
        await requestData()
    }

    // MARK: 请求数据前进行并检查
    /// 运行时对 continuation 进行检查是否调用 `resume` 进行返回
    /// 如果不调用会造成资源泄露。多次调用也会造成问题
    func requestData() async -> String {
        await withCheckedContinuation { continuation in
            /// 模拟网络请求异步回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                continuation.resume(returning: "我是结果")
            }
        }
    }
    
    // MARK: 请求数据前不进行检查
    /// 运行时不会对 continuation 进行检查
    /// 比 withCheckedContinuation 性能好
    /// 先使用 withCheckedContinuation 测试确认没有问题后正式版可改用 withUnsafeContinuation
    func requestData_unsafe() async -> String {
        await withUnsafeContinuation({ continuation in
            /// 模拟网络请求异步回调
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                continuation.resume(returning: "我是结果")
            }
        })
    }
}
