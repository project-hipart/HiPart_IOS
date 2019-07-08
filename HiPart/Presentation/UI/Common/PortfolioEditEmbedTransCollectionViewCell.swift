//
//  PortfolioEditEmbedTransCollectionViewCell.swift
//  HiPart
//
//  Created by 최은희 on 08/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class PortfolioEditEmbedTransCollectionViewCell: UICollectionViewCell {
	@IBOutlet var beforeLabel: UILabel!
	@IBOutlet var afterLabel: UILabel!
	
	var uploadTrans : UploadTrans?{
		didSet{
			beforeLabel.text = self.uploadTrans?.before
			afterLabel.text = self.uploadTrans?.after
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
