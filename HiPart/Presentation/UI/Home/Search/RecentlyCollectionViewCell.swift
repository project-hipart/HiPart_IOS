//
//  RecentlyCollectionViewCell.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

protocol RecentlyCollectionViewCellDelegate : NSObjectProtocol{
	func onTapXButton(title : String, idx : Int)
}

class RecentlyCollectionViewCell: UICollectionViewCell {
	var idx : Int = 0
	weak var delegate : RecentlyCollectionViewCellDelegate? = nil
	@IBOutlet var titleLabel: UILabel!
	
	var title : String = ""{
		didSet{
			titleLabel.text = title
		}
	}
	
	@IBAction func tapXButton(_ sender: Any) {
		delegate?.onTapXButton(title : self.titleLabel.text ?? "", idx : idx)
	}
}
