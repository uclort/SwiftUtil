//
//  HmKeyBoardViewController.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/6/22.
//

import UIKit

class HmKeyBoardViewController: HmBaseViewController {
    
    private var mainScrollView = UIScrollView()
    
    private var mainView = UIView()

    override func addCustomControl() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        let typeGroup: [(UIKeyboardType, String)] = [
            (.default, "default"),
            (.asciiCapable, "asciiCapable"),
            (.numbersAndPunctuation, "numbersAndPunctuation"),
            (.URL, "URL"),
            (.numberPad, "numberPad"),
            (.phonePad, "phonePad"),
            (.namePhonePad, "namePhonePad"),
            (.emailAddress, "emailAddress"),
            (.decimalPad, "decimalPad"),
            (.twitter, "twitter"),
            (.webSearch, "webSearch"),
            (.asciiCapableNumberPad, "asciiCapableNumberPad")
        ]
        let fieldGroup: [HmTextField] = typeGroup.map { (tuple) -> HmTextField in
            let textField = HmTextField()
            textField.keyboardType = tuple.0
            textField.borderWidth = 1 / UIScreen.main.scale
            textField.borderColor = UIColor.black.withAlphaComponent(0.6)
            textField.cornerRadius = 3
            textField.placeholder = tuple.1
            textField.font = UIFont.systemFont(ofSize: 15)
            mainView.addSubview(textField)
            return textField
        }
        fieldGroup.snp.distributeViewsAlong(axisType: .vertical, fixedSpacing: 20, leadSpacing: 20, tailSpacing: 20)
        fieldGroup.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(15)
            maker.height.equalTo(40)
        }
    }
    
    override func addCustomControlConstraint() {
        mainScrollView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        mainView.snp.makeConstraints { (maker) in
            maker.edges.width.equalToSuperview()
        }
    }

}
