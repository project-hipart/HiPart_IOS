//
//  ViewExtension.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView{
	func setImage(withUrl : String?){
		Alamofire.request
		
		debugE(withUrl)
		guard let path = withUrl else {return}
		
		DispatchQueue.global(qos: .userInitiated).async {
			do{
				let url = URL(fileURLWithPath: path)
				debugE(url.absoluteString)
				let imageData: Data = try Data(contentsOf: url)
				
				DispatchQueue.main.async {
					let image = UIImage(data: imageData)
					self.image = image
				}
			}catch{
				print("Unable to load data: \(error)")
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
