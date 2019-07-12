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
            self.titleLabel.text = self.uploadVideo?.title
			self.bodyLabel.text = self.uploadVideo?.content
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		setupView()
        // Initialization code
    }
	
	private func setupView(){
		let tap = UITapGestureRecognizer()
		tap.addTarget(self, action: #selector(tapImage))
		tap.delegate = self
		self.contentView.addGestureRecognizer(tap)
	}
	@objc private func tapImage(){
		if let url = URL(string: self.uploadVideo?.url ?? ""){
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
		
	}

}
extension PortfolioEditEmbedCollectionViewCell : UIGestureRecognizerDelegate{
	override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
