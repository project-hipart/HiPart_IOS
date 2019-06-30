//
//  ViewExtension.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

extension UITabBarController{
    func setSelectedItem(index : Int){
        if let vc = self.viewControllers?[index]{
            self.selectedViewController = vc
        }
    }
}
