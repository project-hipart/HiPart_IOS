//
//  PortfolioUploadViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

import SwiftyJSON

class PortfolioUploadTranslationViewController: UIViewController {
	@IBOutlet var foreginView: UIView!
	@IBOutlet var koreanView: UIView!
	
	@IBOutlet var foreignTextView: UITextView!
	@IBOutlet var koreanTextView: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		addKeyboardNotifications()
		setupView()
		
		foreignTextView.delegate = self
		koreanTextView.delegate = self
    }
    
	

}


extension PortfolioUploadTranslationViewController{
	private func setupView(){
		foreignTextView.delegate = self
	}
	
	func addKeyboardNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow(notification:)),
											   name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide(notification:)),
											   name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
			
			UIView.animate(withDuration: duration){[unowned self] in
				self.view.transform = CGAffineTransform.init(translationX: 0, y: -keyboardSize.height)
				self.view.layoutIfNeeded()
			}
		}
	}
	@objc func keyboardWillHide(notification: NSNotification) {
		let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
		UIView.animate(withDuration: duration) {
			self.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
			self.view.setNeedsLayout()
		}
	}
}
extension PortfolioUploadTranslationViewController : UITextViewDelegate{
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		textView.superview?.borderColor = UIColor.mainPurple
		
		return true
	}
	func textViewDidEndEditing(_ textView: UITextView) {
		textView.superview?.borderColor = UIColor.lightGray
	}
	
}
extension PortfolioUploadTranslationViewController{
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@IBAction func tapUploadView(_ sender: Any) {
		let before = self.foreignTextView.text ?? ""
		let after  = self.koreanTextView.text ?? ""
		
		LoadingView.showLoadingView()
		
		PortfolioRepository.shared.translatorUpload(before: before, after: after){json in
			if let json = json{
				UploadSuccessView.showUploadSuccess()
				
				LoadingView.hideLoadingView()
			}else{
				LoadingView.hideLoadingView()
			}
		}
	}
	
}
