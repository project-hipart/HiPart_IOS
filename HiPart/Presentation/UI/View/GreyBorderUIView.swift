//
//  GreyBorderView.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class GreyBorderUIView: UIView {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.borderColor = UIColor.lightGrey.cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 1.0
        
    }
    
}
