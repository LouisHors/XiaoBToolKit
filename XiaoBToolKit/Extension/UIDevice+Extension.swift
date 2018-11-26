//
//  UIDevice+Extension.swift
//  vankeclub
//
//  Created by 刘豪 on 2018/11/15.
//  Copyright © 2018 yhb. All rights reserved.
//

let screenScale = UIScreen.main.scale

struct iPhoneDisplay {
    
    struct x {
        static let isXTypePhone: Bool = UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width > 2
        static let x: CGSize = CGSize(width: 1125.0 / screenScale, height: 2436.0 / screenScale)
        static let xr: CGSize = CGSize(width: 828.0 / screenScale, height: 1792.0 / screenScale)
        static var xs: CGSize {
            get {
                return x
            }
        }
        static let xsMax: CGSize = CGSize(width: 1242.0 / screenScale, height: 2688.0 / screenScale)
    }
}


extension UIDevice {
    static func isX() -> Bool {
        return iPhoneDisplay.x.isXTypePhone
    }
}

extension Int {
    func widthScale() -> CGFloat {
        return CGFloat(self) * SCREEN_WIDTH / 375.0
    }
    
    func heightScale() -> CGFloat {
        if UIDevice.isX() {
            return CGFloat(self) * SCREEN_WIDTH / 375.0
        }else {
            return CGFloat(self) * SCREEN_HEIGHT / 667.0
        }
    }
}

extension CGFloat {
    var widthScale: CGFloat {
        get {
            return self * SCREEN_WIDTH / 375.0
        }
    }
    
    var heightScale: CGFloat {
        get {
            if UIDevice.isX() {
                return self * SCREEN_WIDTH / 375.0
            }else {
                return self * SCREEN_HEIGHT / 667.0
            }
        }
    }
}
