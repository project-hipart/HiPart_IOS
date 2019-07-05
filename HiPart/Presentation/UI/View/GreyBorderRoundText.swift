//
//  GreyBorderRoundBtn.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class GreyBorderRoundText: UITextField {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.borderColor = UIColor.lightGrey.cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 1.0
        
    }
    
}
