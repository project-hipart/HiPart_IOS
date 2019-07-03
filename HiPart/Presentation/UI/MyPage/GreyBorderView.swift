//
//  GreyBorderView.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class GreyBorderView: UIView {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0).cgColor
        layer.borderWidth = 1.0
        
    }
    
}
