//
//  HmStackViewController.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/7/5.
//

import UIKit

class HmStackViewController: HmBaseViewController {

    override func addCustomControl() {
        let stackView = UIStackView()
        stackView.backgroundColor = .red
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(10)
            maker.centerY.equalToSuperview()
            maker.height.equalTo(50)
        }
        
        let view1 = UIView()
        view1.backgroundColor = .black
        stackView.addArrangedSubview(view1)
        
        let view2 = UIView()
        view2.backgroundColor = .black
        stackView.addArrangedSubview(view2)
    }

}
