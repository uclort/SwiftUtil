//
//  ViewController.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/7.
//

import UIKit

enum ControllerData: String, CaseIterable {
    case keyBoardType = "UITextField.keyBoardType"
    case stackView = "UIStackView"
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
    }
    
    override func addCustomControlConstraint() {
        mainTableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
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

