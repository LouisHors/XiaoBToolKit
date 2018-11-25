//
//  UIColor+XBKit.swift
//  XiaobToolKit
//
//  Created by 刘豪 on 2018/8/14.
//
import Foundation

extension XBKit where Base: UIColor {
    
    /// 随机颜色
    public static var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    /// 获取6位16进制 RGB 数值对应的颜色
    ///
    /// - Parameters:
    ///   - hexString: 16进制 RGB 数值
    ///   - alpha: 透明度
    /// - Returns: 颜色
    public static func hexValueWithAlpha(_ hexString: String, alpha: CGFloat? = 1.0) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = alpha!
        
        let scanner = Scanner(string: hexString)
        var hexComponent: CUnsignedLongLong = 0
        let scannerResult: Bool = scanner.scanHexInt64(&hexComponent)
        
        func verifyHexValue() -> Bool {
            let length = hexString.count
            if (length == 3 || length == 6) && scannerResult {
                return true
            } else {
                return false
            }
        }
        
        let checkResult = verifyHexValue()
        assert(checkResult, "Invalid Hex Color Value")
        
        switch hexString.count {
        case 3:
            red = CGFloat((hexComponent & 0xF00) >> 8 * 17) / 255.0
            green = CGFloat((hexComponent & 0x0F0) >> 4 * 17) / 255.0
            blue = CGFloat(hexComponent & 0x00F * 17) / 255.0
        case 6:
            red = CGFloat((hexComponent & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexComponent & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexComponent & 0x0000FF) / 255.0
        default:
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 获取16进制 RGB 数值对应的颜色(不透明)
    ///
    /// - Parameter hexString: 16进制 RGB 数值
    /// - Returns: 颜色
    public static func hexValue(_ hexString: String) -> UIColor {
        return self.hexValueWithAlpha(hexString, alpha: 1.0)
    }
    
    /// 给 View 加一层渐变 layer
    ///
    /// - Parameters:
    ///   - view:
    ///   - fromColor: 渐变起始颜色
    ///   - toColor: 渐变结束颜色
    /// - Returns: layer
    public static func setGradualChangingColor(view: UIView, fromColor: UIColor, toColor: UIColor) -> CAGradientLayer {
        let layer = CAGradientLayer.init()
        layer.frame = view.bounds
        layer.colors = [fromColor.cgColor, toColor.cgColor]
        layer.startPoint = CGPoint.init(x: 0, y: 0)
        layer.endPoint = CGPoint.init(x: 1, y: 0)
        return layer
    }
}
