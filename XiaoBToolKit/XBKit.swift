//
//  XBKit.swift
//  XiaobToolKit
//
//  Created by 刘豪 on 2018/8/14.
//
import Foundation

public struct XBKit<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol XBKitCompatible {
    associatedtype BaseType
    
    static var xb: BaseType.Type { get }
    var xb: BaseType { get }
}

extension XBKitCompatible {
    public static var xb: XBKit<Self>.Type {
        return XBKit<Self>.self
    }
    
    public var xb: XBKit<Self> {
        return XBKit(self)
    }
}

extension NSObject: XBKitCompatible { }
