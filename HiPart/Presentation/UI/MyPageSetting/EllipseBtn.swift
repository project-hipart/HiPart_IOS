//
//  EllipseBtn.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class EllipseBtn: UIButton {
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.cornerRadius = 6
        
    }
}
