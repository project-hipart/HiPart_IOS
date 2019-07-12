//
//  MyPageSettingViewController.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero
import SwiftyJSON

class MyPageSettingViewController: UIViewController {

    @IBOutlet weak var myPageImg: RoundImg!
    @IBOutlet weak var nickNameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var cpatBtn: RoundBtn!
    @IBOutlet weak var epatBtn: RoundBtn!
    @IBOutlet weak var tpatBtn: RoundBtn!
    @IBOutlet weak var etcBtn: RoundBtn!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyPageAPI.requestMyInfoView { json in
            if let json = json {
                let data = json["data"].arrayValue[0]
                let url = data["user_img"].stringValue
                let nickname = data["user_nickname"].stringValue
                let number = data["user_number"].stringValue
                
                if json["success"].boolValue {
                
                    debugE(json)
                    
                    self.myPageImg.setImage(withUrl: url){
                        LoadingView.hideLoadingView()
                    }
                    self.nickNameText.text = nickname
                    self.numberText.text = number
                    
                    
                } else {
                    LoadingView.hideLoadingView()
                }
            } else {
                LoadingView.hideLoadingView()
            }
        }
		addKeyboardNotification(self, #selector(willShow), #selector(willHide))
	}
	
	@objc private func willShow(notification: NSNotification){
		UIView.animate(withDuration: notification.duration){
			self.view.transform = CGAffineTransform.init(translationX: 0, y: -150)
		}
	}
	@objc private func willHide(notification: NSNotification){
		UIView.animate(withDuration: notification.duration){
			self.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
		}
	}
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.hero.dismissViewController()
    }
    
}
extension MyPageSettingViewController: UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
		
	}
}


extension MyPageSettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func changeMyImg(_ sender: RoundBtn) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let possibleImage = info[.editedImage] as? UIImage {
            self.myPageImg.image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            self.myPageImg.image = possibleImage
        } else {
            return
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
