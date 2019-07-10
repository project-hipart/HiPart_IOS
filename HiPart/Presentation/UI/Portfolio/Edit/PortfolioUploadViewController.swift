//
//  PortfolioUploadViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero


class PortfolioUploadViewController: UIViewController {
	@IBOutlet var urlTextField: UITextField!
	@IBOutlet var imageView: UIImageView!
	
	@IBOutlet var titleLabel : UILabel!
	@IBOutlet var contentLabel : UILabel!
	
	@IBOutlet var imageUploadContainerView: UIView!
	
	var isImageUploaded = false
	var imageInfo : [UIImagePickerController.InfoKey : Any]? = nil
	var isTitleUploaded = false
	var isContentUploaded = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
	}
	
	
	
	
}
//MARK: Actions
extension PortfolioUploadViewController{
	@IBAction func tapTitleLabel(_ sender: Any) {
		let dialog = UIAlertController(title: "제목 입력", message: nil , preferredStyle: .alert)
		
		let ok = UIAlertAction(title: "확인", style: .default, handler: {[unowned dialog] _ in
			if let tf = dialog.textFields?.first{
				let text = tf.text ?? ""
				self.titleLabel.text = text
				self.isTitleUploaded = true
			}
		})
		let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
		
		dialog.addTextField(configurationHandler: {textField in
			textField.placeholder = "제목을 적어주세요"
		})
		dialog.addAction(ok)
		dialog.addAction(cancel)
		
		
		self.present(dialog, animated: false, completion: nil)
	}
	@IBAction func tapContentLabel(_ sender: Any) {
		let dialog = UIAlertController(title: "설명 입력", message: nil , preferredStyle: .alert)
		
		let ok = UIAlertAction(title: "확인", style: .default, handler: {[unowned dialog] _ in
			if let tf = dialog.textFields?.first{
				let text = tf.text ?? ""
				self.contentLabel.text = text
				self.isContentUploaded = true
			}
		})
		let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
		
		dialog.addTextField(configurationHandler: {textField in
			textField.placeholder = "작품을 빛내줄 한줄을 적어주세요 (최대 40자 이내)"
		})
		dialog.addAction(ok)
		dialog.addAction(cancel)
		
		
		self.present(dialog, animated: false, completion: nil)
	}
	@IBAction func tapImageUploadView(_ sender: Any) {
		let picker = UIImagePickerController()
		picker.sourceType = .photoLibrary
		picker.delegate = self
		
		self.present(picker, animated: true, completion: nil)
	}
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	
	@IBAction func tapUploadButton(_ sender: Any) {
		if !isImageUploaded || !isTitleUploaded || !isContentUploaded{
			return
			
		}
		
		LoadingView.showLoadingView()
		
		let thumbnail = (self.imageInfo![.originalImage] as! UIImage).jpegData(compressionQuality: 0.95)
		let thumbnailUrl = self.imageInfo![.imageURL] as! NSURL
		let url = self.urlTextField.text ?? ""
		let title = self.titleLabel.text ?? ""
		let content = self.contentLabel.text ?? ""
		PortfolioRepository.shared.creatorUpload(thumbnail: thumbnail!, thumbnailUrl: thumbnailUrl.absoluteString!, url: url, title: title, content: content){json in
			
			if let json = json{
				if json["success"].boolValue{
					UploadSuccessView.showUploadSuccess()
				}
				LoadingView.hideLoadingView()
			}else{
				LoadingView.hideLoadingView()
			}
			
		}
	}
}

extension PortfolioUploadViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		
		guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
			else {
				fatalError()
		}
		imageInfo = info
		
		self.imageView.image = selectedImage
		isImageUploaded = true
		imageUploadContainerView.borderColor = UIColor.mainPurple
		dismiss(animated: true, completion: nil)
	}
}
extension PortfolioUploadViewController{
	private func setupView(){
		self.urlTextField.addLeftPadding(16)
		contentLabel.setLineHeight(lineHeight: 1.5)
		self.imageView.layer.masksToBounds = true
	}
}
