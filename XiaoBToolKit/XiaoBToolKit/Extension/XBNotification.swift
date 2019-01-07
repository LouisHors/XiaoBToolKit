//
//  XBNotification.swift
//  XiaoBToolKit
//
//  Created by 刘豪 on 2018/8/15.
//
import Foundation

let XB = "XB"

struct XBNotification: RawRepresentable {
    typealias RawValue = String
    var rawValue: String
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
extension XBNotification {
    var stringValue: String {
        return XB + rawValue
    }
    
    var notificationName: Notification.Name {
        return NSNotification.Name(stringValue)
    }
}

extension NotificationCenter {
    func vkypost(vky name: XBNotification, object: Any? = nil){
        NotificationCenter.default.post(name: name.notificationName, object: object)
    }
    
    func vkypost(vky name: XBNotification, object: Any? = nil, userInfo: [String: Any]? = nil){
        NotificationCenter.default.post(name: name.notificationName, object: object, userInfo: userInfo)
    }
}
