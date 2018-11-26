//
//  Validatable.swift
//  vankeclub
//
//  Created by 刘豪 on 2018/8/9.
//  Copyright © 2018年 yhb. All rights reserved.
//

import Foundation

protocol Validatable {
    // 关联类型
    associatedtype RegexValidType
    // 方法
    func isValid(by regex: RegEx) -> RegexValidType
}

extension String: Validatable {
    func isValid(by regex: RegEx) -> RegexValidType {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
        return predicate.evaluate(with: self)
    }
    typealias RegexValidType = Bool
}


