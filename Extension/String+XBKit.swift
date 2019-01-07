//
//  String+XBKit.swift
//  XiaoBToolKit
//
//  Created by 刘豪 on 2018/8/14.
//
import Foundation

extension String {
    
    /// string 转 Int
    ///
    /// - Returns: int 数值(如果可以的话)
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// string 转 Double
    ///
    /// - Returns: double 数值(如果可以的话)
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// string 转 float
    ///
    /// - Returns: float 数值(如果可以的话)
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
}

public struct XBStringProxy {
    fileprivate let value: String
    init(proxy: String) {
        value = proxy
    }
}

extension String: XBKitCompatible {
    public typealias BaseType = XBStringProxy
    public static var xb: XBStringProxy.Type {
        return XBStringProxy.self
    }
    public var xb: XBStringProxy {
        return XBStringProxy(proxy: self)
    }
}

extension XBStringProxy {
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: value) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: value) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: value) {
            return num.floatValue
        } else {
            return nil
        }
    }
}
