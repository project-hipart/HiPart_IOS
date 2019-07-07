//
//  ViewExtension.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView{
	func setImage(withUrl : String?){
		guard let path = withUrl else {return}
		
		
		Alamofire.request(path).responseImage { response in
			if let image = response.result.value {
				self.image = image
//				print("image downloaded: \(image)")
			}
		}
	}
}

extension UITabBarController{
    func setSelectedItem(index : Int){
        if let vc = self.viewControllers?[index]{
            self.selectedViewController = vc
        }
    }
}
extension UIStackView{
	func addPaddingView(){
		let paddingView = UIView()
		paddingView.translatesAutoresizingMaskIntoConstraints=false
		
		if self.axis == .horizontal{
			paddingView.setContentHuggingPriority(.defaultLow, for: .horizontal)
		}else{
			paddingView.setContentHuggingPriority(.defaultLow, for: .vertical)
		}
		
		self.addArrangedSubview(paddingView)
		
	}
	
	@IBInspectable
	var addPadding : Bool{
		get{
			return false
		}
		set{
			self.addPaddingView()
		}
	}
}
