//
//  SignUpFinishCell.swift
//  HiPart
//
//  Created by 최은희 on 08/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class SignUpFinishCell: UICollectionViewCell {
    @IBOutlet weak var signUpFinishImg: UIImageView!
    @IBOutlet weak var signUpFinishTitle: UILabel!
    @IBOutlet weak var signUpFinishSmallTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        layer.borderColor = UIColor.lightGrey.cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 1.0
        
    }
}
