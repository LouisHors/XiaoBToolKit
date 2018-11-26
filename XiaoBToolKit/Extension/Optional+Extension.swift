//
//  Optional+Extension.swift
//  vankeclub
//
//  Created by 刘豪 on 2018/11/22.
//

import Foundation
//MARK:- 基本判断 & 默认值
extension Optional {
    var isNone: Bool {
        switch self {
        case .none:
            return true
        default:
            return false
        }
    }
    
    var isSome: Bool {
        return !isNone
    }
    
    /// 返回可选值或者默认值
    ///
    /// - Parameter default: 默认值
    /// - Returns: 如果可选值为空, 则返回默认值
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    
    /// 返回可选值或`else` 表达式返回值
    ///
    /// - Parameter else: 如果为空的处理 closure
    /// - Returns:  可选值或者`else` 的返回值
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 可选值不为空时, 返回可选值
    ///
    /// - Parameter exception: 为空时抛出异常
    /// - Returns: 不为空时的可选值
    /// - Throws: 为空时的异常
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
}

extension Optional where Wrapped == Error {
    
    /// 当可选值不为空时, 执行 else
    ///
    /// - Parameter else: <#else description#>
    func or(_ else: (Error) -> Void) {
        
        guard let error = self else { return }
        `else`(error)
    }
}

//MARK:- 变换
extension Optional {
    
    /// 可选值变换返回, 如果可选值为空, 则返回默认值
    ///
    /// - Parameters:
    ///   - fn: 映射值的闭包
    ///   - default: 可选值为空的时候, 将作为返回值
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(fn) ?? `default`
    }
    
    /// 可选值变换并返回, 如果可选值为空, 则调用`else`闭包
    ///
    /// - Parameters:
    ///   - fn: 映射值的闭包
    ///   - else: 可选值为空时处理的闭包
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }
    
    /**
     *  e.g.
     *  let optional1: String? = "hello world"
     *  let optional2: String? = nil
     *  使用前
     *  optional1.map({ $0.count }) ?? 0
     *  optional2.map({ $0.count }) ?? 0
     *  使用后
     *  optional1.map({ $0.count }, default: 0)
     *  optional2.map({ $0.count }, else: { "default".count })
     */
}

//MARK:- 组合
extension Optional {
    
    /// 当可选值不为空时, 解包并返回`optional`
    ///
    /// - Parameter optional: <#optional description#>
    /// - Returns: <#return value description#>
    func and<B>(_ optional: B?) -> B? {
        guard self != nil else { return nil }
        return optional
    }
    
    /// 解包可选值, 当可选值不为空时, 执行`then`闭包, 并返回执行结果
    /// 将多个可选项连在一起
    func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    
    /// 将当前可选值与其它可选值组合在一起
    /// 当前仅当两个可选值都不为空时组合成功, 否则返回nil
    func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }
    
    /// 将当前可选值与其它可选值组合在一起
    /// 当前仅当三个可选值都不为空时组合成功, 否则返回nil
    func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
        guard let first = self,
        let second = other,
        let third = another else { return nil }
        return (first, second, third)
    }
    
    /**
     *  e.g.
     *  使用前
     *  if user != nil, let account = userAccount() ...
     *  使用后
     *  if let account = user.and(userAccount()) ...
     */
    
    /// 当可选值不为空时, 执行`some`闭包
    func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }
    
    /// 当可选值为空时, 执行`none` 闭包
    func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
}

extension Optional {
    
    /// 可选值不为空且可选值满足`predicate`条件才返回, 否则返回nil
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
        predicate(unwrapped) else { return nil }
        return self
    }
    
    /// 可选值不为空时返回, 否则直接 crash
    func expect(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
    
    /**
     *  e.g.
     *  before
     *  if let aUser = user, user.id < 1000 { aUser.doSomething() }
     *  after
     *  user.filter({ $0.id < 1000 })?.doSomething()
     */
}


