//
//  BlurExtension.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

extension UIView {
    func addBlurArea(area: CGRect, style: UIBlurEffect.Style) -> UIView {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        container.alpha = 0.9
        container.tag = -55
        self.insertSubview(container, at: 1)
        return container
    }
    func removeBlurView(){
        for v in self.subviews{
            if v.tag == -55{
                v.removeFromSuperview()
            }
        }
        
    }
}
