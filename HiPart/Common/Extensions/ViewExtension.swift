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
<<<<<<< HEAD
=======

extension UILabel {
	func setLineHeight(lineHeight: CGFloat) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 1.0
		paragraphStyle.lineHeightMultiple = lineHeight
		paragraphStyle.alignment = self.textAlignment
		
		let attrString = NSMutableAttributedString()
		if (self.attributedText != nil) {
			attrString.append( self.attributedText!)
		} else {
			attrString.append( NSMutableAttributedString(string: self.text!))
			attrString.addAttribute(NSAttributedString.Key.font, value: self.font, range: NSMakeRange(0, attrString.length))
		}
		attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
		self.attributedText = attrString
	}
}

extension UITextField{
	func addLeftPadding(_ padding : CGFloat){
		let view = UIView(frame:CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
		self.leftView = view
		self.leftViewMode = .always
	}
}
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
