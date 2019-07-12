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
    func setImage(withUrl : String?, completion : (() -> Void)? = nil){
		guard let path = withUrl else {return}
		
		
		Alamofire.request(path).responseImage { response in
			if let image = response.result.value {
				self.image = image
                completion?()
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
	func getSelectedItem(_ idx : Int) -> UIViewController{
		if let vc = self.viewControllers?[idx]{
			return vc
		}
		fatalError()
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

extension UIViewController{
	func showEditAlertDialog(_ title : String = "제목 입력", _ completion : @escaping (String) -> Void ){
		let dialog = UIAlertController(title: title, message: nil , preferredStyle: .alert)
		
		let ok = UIAlertAction(title: "확인", style: .default, handler: {[unowned dialog] _ in
			if let tf = dialog.textFields?.first{
				
				if let text = tf.text{
					completion(text)
				}
			}
		})
		let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
		
		dialog.addTextField(configurationHandler: {textField in
			textField.placeholder = "수정하기"
		})
		dialog.addAction(ok)
		dialog.addAction(cancel)
		self.present(dialog, animated: true, completion: nil)
	}
	
}
extension UICollectionView {
	
	func snapToCell(velocity: CGPoint, targetOffset: UnsafeMutablePointer<CGPoint>, contentInset: CGFloat = 0, spacing: CGFloat = 0) {
		
		// No snap needed as we're at the end of the scrollview
		guard (contentOffset.x + frame.size.width) < contentSize.width else { return }
		guard let indexPath = indexPathForItem(at: targetOffset.pointee) else { return }
		guard let cellLayout = layoutAttributesForItem(at: indexPath) else { return }
		
		var offset = targetOffset.pointee
		
		if velocity.x < 0 {
			offset.x = cellLayout.frame.minX - max(contentInset, spacing)
		} else {
			offset.x = cellLayout.frame.maxX - contentInset + min(contentInset, spacing)
		}
		
		targetOffset.pointee = offset
	}
}


