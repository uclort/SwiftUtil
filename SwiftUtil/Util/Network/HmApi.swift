//
//  HmApi.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/9/2.
//

import Foundation

enum HmApi: String {
    case test1 = "/util/test1"
    case test2 = "/util/test2"

    private var BaseUrl: String {
        "https://www.fastmock.site/mock/"
    }

    private var appID: String {
        "d806240d6e7778d22fd1169fa89daebd"
    }

    var url: String {
        "\(BaseUrl)\(appID)\(rawValue)"
    }
}
