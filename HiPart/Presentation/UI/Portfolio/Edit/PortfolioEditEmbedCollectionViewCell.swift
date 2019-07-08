//
//  PortfolioUploadCollectionViewCell.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class PortfolioEditEmbedCollectionViewCell: UICollectionViewCell {

	@IBOutlet var imageView: UIImageView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var bodyLabel: UILabel!
	
	var uploadVideo : UploadVideo?{
		didSet{
			self.imageView.setImage(withUrl: uploadVideo?.thumbnail)
			self.titleLabel.text =
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
