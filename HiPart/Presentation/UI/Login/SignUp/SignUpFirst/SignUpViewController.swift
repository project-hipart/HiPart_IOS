//
//  SignUpViewController.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpNextBtn: EllipsePurpleLongBtn!
    @IBOutlet weak var myImg: RoundImg!
    @IBOutlet weak var emailTypeCheckLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    @IBOutlet weak var nickCheck: UILabel!
    
    @IBOutlet weak var signUpEmailView: UIView!
    @IBOutlet weak var signUpEmailImg: UIImageView!
    @IBOutlet weak var signUpEmailTextfield: UITextField!
    
    @IBOutlet weak var signUpPwView: UIView!
    @IBOutlet weak var signUpPwImg: UIImageView!
    @IBOutlet weak var signUpPwTextfield: UITextField!
    
    @IBOutlet weak var signUpPwCheckView: UIView!
    @IBOutlet weak var signUpPwCheckImg: UIImageView!
    @IBOutlet weak var signUpPwCheckTextfield: UITextField!
    
    @IBOutlet weak var signUpNickView: UIView!
    @IBOutlet weak var signUpNickImg: UIImageView!
    @IBOutlet weak var signUpNickTextfield: UITextField!
    
    @IBOutlet weak var signUpContactView: UIView!
    @IBOutlet weak var signUpContactImg: UIImageView!
    @IBOutlet weak var signUpContactTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpNextBtn.setTitleColor(UIColor.white, for: .normal)

        signUpEmailTextfield.delegate = self
        signUpPwTextfield.delegate = self
        signUpPwCheckTextfield.delegate = self
        signUpNickTextfield.delegate = self
        signUpContactTextfield.delegate = self
        
        signUpNextBtn.backgroundColor = UIColor.lightGrey
        signUpNextBtn.isEnabled = false
        
        emailTypeCheckLabel.isHidden = true
        pwCheckLabel.isHidden = true
        nickCheck.isHidden = true
        
//        print(isValidEmail(emailStr: "eun95828@naver.com"))
//        print(isValidEmail(emailStr: "eun95828"))
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func selecMytImg(_ sender: RoundBtn) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let possibleImage = info[.editedImage] as? RoundImg {
            self.myImg = possibleImage
        } else if let possibleImage = info[.originalImage] as? RoundImg {
            self.myImg = possibleImage
        } else {
            return
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}

extension SignUpViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == signUpEmailTextfield {
            if newString.length == 0 {
                signUpEmailView.borderColor = UIColor.lightGrey
                signUpEmailImg.image = UIImage(named: "loginIdOffIcon")
            } else {
                signUpEmailView.borderColor = UIColor.mainPurple
                signUpEmailImg.image = UIImage(named: "loginIdOnIcon")
            }
        }
            
        else if textField == signUpPwTextfield {
            if newString.length == 0 {
                signUpPwView.borderColor = UIColor.lightGrey
                signUpPwImg.image = UIImage(named: "loginPasswordOffIcon")
            } else {
                signUpPwView.borderColor = UIColor.mainPurple
                signUpPwImg.image = UIImage(named: "loginPasswordOnIcon")
            }
        }
        
        else if textField == signUpPwCheckTextfield {
            if newString.length == 0 {
                signUpPwCheckView.borderColor = UIColor.lightGrey
                signUpPwCheckImg.image = UIImage(named: "loginPasswordOffIcon")
            } else {
                signUpPwCheckView.borderColor = UIColor.mainPurple
                signUpPwCheckImg.image = UIImage(named: "loginPasswordOnIcon")
            }
        }
        
        else if textField == signUpNickTextfield {
            if newString.length == 0 {
                signUpNickView.borderColor = UIColor.lightGrey
                signUpNickImg.image = UIImage(named: "loginNicknameOffIcon")
            } else {
                signUpNickView.borderColor = UIColor.mainPurple
                signUpNickImg.image = UIImage(named: "loginNicknameOnIcon")
            }
        }
        
        else if textField == signUpContactTextfield {
            if newString.length == 0 {
                signUpContactView.borderColor = UIColor.lightGrey
                signUpContactImg.image = UIImage(named: "loginPhoneOffIcon")
            } else {
                signUpContactView.borderColor = UIColor.mainPurple
                signUpContactImg.image = UIImage(named: "loginPhoneOnIcon")
            }
        }
        
        if (signUpEmailView.borderColor == UIColor.mainPurple) && (signUpPwView.borderColor == UIColor.mainPurple)
           && (signUpPwCheckView.borderColor == UIColor.mainPurple) && (signUpNickView.borderColor == UIColor.mainPurple)
           && (signUpContactView.borderColor == UIColor.mainPurple) {
            self.signUpNextBtn.backgroundColor = UIColor.mainPurple
            self.signUpNextBtn.isEnabled = true
        } else {
            self.signUpNextBtn.backgroundColor = UIColor.lightGrey
            self.signUpNextBtn.isEnabled = false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == signUpEmailTextfield {
            if isValidEmail(emailStr: signUpEmailTextfield.text ?? "") == false {
                emailTypeCheckLabel.text = "잘못된 형식"
                emailTypeCheckLabel.textColor = UIColor.red
                emailTypeCheckLabel.isHidden = false
            } else {
                emailTypeCheckLabel.isHidden = true
            }
            AuthAPI.requestDuplicateCheck(flag: .email, input: signUpEmailTextfield.text!)
                .subscribe(onSuccess: {json in
                    print(json["data"].intValue)
                    if json["data"].intValue == 0 {
                        self.emailTypeCheckLabel.isHidden = true
                    } else if json["data"].intValue == 1 {
                        self.emailTypeCheckLabel.isHidden = false
                        self.emailTypeCheckLabel.text = "중복"
                        self.emailTypeCheckLabel.textColor = UIColor.red
                    }
                }, onError: {err in
                    
                })
        }
        
        else if textField == signUpPwCheckTextfield {
            if signUpPwTextfield.text != signUpPwCheckTextfield.text {
                pwCheckLabel.text = "불일치"
                pwCheckLabel.textColor = UIColor.red
                pwCheckLabel.isHidden = false
            } else {
                pwCheckLabel.isHidden = true
            }
        }
        
        else if textField == signUpNickTextfield {
            AuthAPI.requestDuplicateCheck(flag: .nickname, input: signUpNickTextfield.text!)
                .subscribe(onSuccess: {json in
                    print(json["data"].intValue)
                    if json["data"].intValue == 0 {
                        self.nickCheck.isHidden = true
                    } else if json["data"].intValue == 1 {
                        self.nickCheck.isHidden = false
                        self.nickCheck.text = "중복"
                        self.nickCheck.textColor = UIColor.red
                    }
                }, onError: {err in

                })
        }
    }
}

extension SignUpViewController {
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
}
