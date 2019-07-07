//
//  DeviceExtension.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class Device {
    
    static var tabBarHeight: CGFloat = 0
    
    // Base width in point, use iPhone 6
    static let baseWidth: CGFloat = 375
    static let baseHeight: CGFloat = 667
    static var ratioWidth: CGFloat {
        return UIScreen.main.bounds.width / baseWidth
    }
    static var ratioHeight: CGFloat{
        return UIScreen.main.bounds.height / baseHeight
    }
    
    static var screenWidth: CGFloat{
        return UIScreen.main.bounds.width
    }
    static var screenHeight: CGFloat{
        return UIScreen.main.bounds.height
    }
    static var renderViewHeight: CGFloat{
        return screenWidth * 4 / 3
    }
    static var bottomBoxHeight : CGFloat{
        return screenHeight - renderViewHeight
    }
    static var bottomCollectionViewMaxHeight: CGFloat{
        if UI_USER_INTERFACE_IDIOM() == .pad{
            return (screenHeight - screenWidth)/2
        }else{
            return bottomBoxHeight/2
        }
    }
    static var isIphoneSE :Bool{
        
        return screenWidth == 320 && screenHeight == 568
    }
    static var topSafeAreaPadding : CGFloat{
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    static var bottomSafeAreaPadding : CGFloat{
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
}
extension CGFloat {
    var adjustedWidth: CGFloat {
        return self * Device.ratioWidth
    }
    var adjustedHeight:CGFloat{
        return self * Device.ratioHeight
    }
    
}
extension Double {
    var adjustedWidth: CGFloat {
        return CGFloat(self) * Device.ratioWidth
    }
    var adjustedHeight:CGFloat{
        return CGFloat(self) * Device.ratioHeight
    }
}
extension Int {
    var adjustedWidth: CGFloat {
        return CGFloat(self) * Device.ratioWidth
    }
    var adjustedHeight:CGFloat{
        return CGFloat(self) * Device.ratioHeight
    }
}
