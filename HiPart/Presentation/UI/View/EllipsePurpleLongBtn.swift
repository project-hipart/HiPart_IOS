//
//  EllipseBtn.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit


class EllipsePurpleLongBtn: UIButton {
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.cornerRadius = 6
        layer.backgroundColor = UIColor.mainPurple.cgColor

        print(frame)
        
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 275.adjustedWidth, height: 44)
//    }
}
