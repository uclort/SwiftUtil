//
//  HmDataExtension.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/9/2.
//

import Foundation

extension Data {
    func decoded<T: Decodable>(_: T.Type) -> T? {
        guard let model = try? JSONDecoder().decode(T.self, from: self) else {
            return nil
        }
        return model
    }
}
