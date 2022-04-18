//
//  ViewController.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit
import PromiseKit

enum ControllerData: String, CaseIterable {
    case keyBoardType = "UITextField.keyBoardType"
    case stackView = "UIStackView"
    case KingFisher = "KingFisher"
    case await_async = "await_async"
}

class ViewController: HmBaseViewController {
    
    private let mainTableView = UITableView(frame: .zero, style: .plain)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func addCustomControl() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        view.addSubview(mainTableView)
        
        HmTestCode.shared.run()
    }
    
    override func addCustomConstraint() {
        mainTableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    override func sendHandler() {
//        let object1 = HmViewModel.default.requestTest1()
//        let object2 = HmViewModel.default.requestTest2()
//        firstly {
//            when(fulfilled: object1.promise, object2.promise)
//        }.done { model, models in
//            dPrint("1 和 2 全部请求完成")
//            dPrint(model)
//            dPrint(models)
//        }.catch { error in
//            dPrint(error)
//        }.finally {
//            firstly {
//                object1.promise
//            }.then { model -> Promise<[RootRoot]?> in
//                dPrint("1 请求完毕")
//                dPrint(model)
//                return object2.promise
//            }.done {
//                dPrint("2 请求完毕")
//                dPrint($0)
//            }.catch { error in
//                dPrint(error)
//            }.finally {
//                
//            }
//        }
    }

}

extension ViewController {
    private func jumpTargetPageFrom(type: ControllerData) {
        var targetPage: HmBaseViewController?
        switch type {
        case .keyBoardType:
            targetPage = HmKeyBoardViewController()
        case .stackView:
            targetPage = HmStackViewController()
        case .KingFisher:
            targetPage = HmKingFisherVC()
        case .await_async:
            targetPage = await_async()
        }
        guard let target = targetPage else {
            return
        }
        navigationController?.pushViewController(target, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        jumpTargetPageFrom(type: ControllerData.allCases[indexPath.row])
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ControllerData.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = ControllerData.allCases[indexPath.row].rawValue
        return cell
    }
}

