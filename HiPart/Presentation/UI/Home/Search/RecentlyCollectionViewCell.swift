//
//  RecentlyCollectionViewCell.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class RecentlyCollectionViewCell: UICollectionViewCell {
	@IBOutlet var titleLabel: UILabel!
	
	var title : String = ""{
		didSet{
			titleLabel.text = title
		}
	}
	
	@IBAction func tapXButton(_ sender: Any) {
	}
}
