//
//  HmViewModel.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/9/2.
//

import Foundation
import HandyJSON
import PromiseKit

struct RootRoot: Codable {
    var cmd: String = ""

    var code: Int = 0

    var data: String = ""

    var msg: String = ""

    var nightCheck: Bool = false

    var redo: Bool = false

    var success: Bool = false
}

class HmViewModel {
    static let `default` = HmViewModel()
    private let requestManager = HmRequest.default
    private init() {}
    
    func requestTest1() -> HmRequestObject<RootRoot?> {
        requestManager.requestModelFromCodable(HmApi.test1.url, RootRoot.self)
    }
    
    func requestTest2() -> HmRequestObject<[RootRoot]?> {
        requestManager.requestModelGroupFromCodable(HmApi.test2.url, RootRoot.self)
    }
}
