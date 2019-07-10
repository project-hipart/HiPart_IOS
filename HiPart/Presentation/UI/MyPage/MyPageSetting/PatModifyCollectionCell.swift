//
//  PatModifyCollectionCell.swift
//  HiPart
//
//  Created by 최은희 on 11/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class PatModifyCollectionCell: UICollectionViewCell {

    @IBOutlet weak var patModifyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.borderColor = UIColor.lightGrey.cgColor
        layer.cornerRadius = frame.height/2
        layer.borderWidth = 1.0
        
    }
}
