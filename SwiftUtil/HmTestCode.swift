//
//  HmTestCode.swift
//  SwiftUtil
//
//  Created by 侯猛 on 2022/3/22.
//

import Foundation
import HandyJSON

struct TestModel: HandyJSON {
    var title: String?
    var name: String?
    var models: [TestModel]?
}

class HmTestCode {
    static let shared = HmTestCode()

    func run() {
        let jsonObject: [String: Any] = [
            "title": "123",
            "name": "aaa",
            "models": [
                ["title": "456"],
                ["title": "sdf"],
            ],
        ]

//        let data = try! JSONSerialization.data(withJSONObject: jsonObject)
        let model = TestModel.deserialize(from: jsonObject)
        debugPrint(model ?? "")
    }
}
