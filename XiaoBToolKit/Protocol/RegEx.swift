//
//  RegEx.swift
//  vankeclub
//
//  Created by 刘豪 on 2018/8/9.
//  Copyright © 2018年 yhb. All rights reserved.
//

import Foundation

struct RegEx: RawRepresentable {
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    var rawValue: String
    
    typealias RawValue = String
}

extension RegEx {
    // email
    static let EmailValidate = RegEx(rawValue: "([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$")
    // pwd
    static let PasswordValidate = RegEx(rawValue: "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$")
}
