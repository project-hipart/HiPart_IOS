//
//  SignUpViewController.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    private var url : NSURL!
    
    @IBOutlet weak var signUpNextBtn: EllipsePurpleLongBtn!
    @IBOutlet weak var myImg: RoundImg!
    @IBOutlet weak var emailTypeCheckLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    @IBOutlet weak var nickCheck: UILabel!
    @IBOutlet weak var pwLengthCheck: UILabel!
    
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
        pwLengthCheck.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let dstVC = segue.destination as! SignUpFinshViewController
        
        guard let email = signUpEmailTextfield.text else { return }
        dstVC.loginText.append(email)
        
        guard let pw = signUpPwCheckTextfield.text else { return }
        dstVC.loginText.append(pw)
        
        guard let nick = signUpNickTextfield.text else { return }
        dstVC.loginText.append(nick)
        
        guard let contact = signUpContactTextfield.text else { return }
        dstVC.loginText.append(contact)
        
        guard let image = myImg.image else { return }
        
        guard let data = image.jpegData(compressionQuality: 0.95) else { return }
        dstVC.loginData = data
    
        guard let url = self.url else { return }
        guard let imageUrl = url.absoluteString else { return }
        dstVC.imageUrl = imageUrl
        
        
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
        if let possibleImage = info[.editedImage] as? UIImage {
            self.myImg.image = possibleImage
            self.url = info[.imageURL] as? NSURL
        } else if let possibleImage = info[.originalImage] as? UIImage {
            self.myImg.image = possibleImage
            self.url = info[.imageURL] as? NSURL
        } else {
            return
        }
         picker.dismiss(animated: true)
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
            if newString.length < 8 {
                pwLengthCheck.text = "8자 이상"
                pwLengthCheck.textColor = UIColor.red
                pwLengthCheck.isHidden = false
             
                
            } else {
                pwLengthCheck.isHidden = true
         
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
        
        checkAndEnableButton()
        
        return true
    }
    private func checkAndEnableButton(){
        
        if (signUpEmailView.borderColor == UIColor.mainPurple)
            && (signUpPwView.borderColor == UIColor.mainPurple)
            && (signUpPwCheckView.borderColor == UIColor.mainPurple)
            && (signUpNickView.borderColor == UIColor.mainPurple)
            && (signUpContactView.borderColor == UIColor.mainPurple)
            && (emailTypeCheckLabel.isHidden == true)
            && (pwCheckLabel.isHidden == true)
            && (nickCheck.isHidden == true)
            && (pwLengthCheck.isHidden == true) {
            
            self.signUpNextBtn.backgroundColor = UIColor.mainPurple
            self.signUpNextBtn.isEnabled = true
            
        } else {
            self.signUpNextBtn.backgroundColor = UIColor.lightGrey
            self.signUpNextBtn.isEnabled = false
        }
    }
}

extension SignUpViewController {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == signUpEmailTextfield {
//            print(isValidEmail(emailStr: signUpEmailTextfield.text ?? ""))
            if isValidEmail(emailStr: signUpEmailTextfield.text ?? "") == false {
                emailTypeCheckLabel.text = "잘못된 형식"
                emailTypeCheckLabel.textColor = UIColor.red
                emailTypeCheckLabel.isHidden = false
                
                
            } else {
                AuthAPI.requestDuplicateCheck(flag: .email, input: signUpEmailTextfield.text!) { json in
                    if let json = json {
                        if json["data"].intValue == 0 {
                            self.emailTypeCheckLabel.isHidden = true
                        } else if json["data"].intValue == 1 {
                            self.emailTypeCheckLabel.isHidden = false
                            self.emailTypeCheckLabel.text = "중복된 메일"
                            self.emailTypeCheckLabel.textColor = UIColor.red
                        }
                    } else {}
                }
            }
        }
        
        if textField == signUpPwCheckTextfield {
            if signUpPwCheckTextfield.text != signUpPwTextfield.text {
                pwCheckLabel.text = "불일치"
                pwCheckLabel.textColor = UIColor.red
                pwCheckLabel.isHidden = false
             
                
            } else if signUpPwCheckTextfield.text == signUpPwTextfield.text {
                pwCheckLabel.isHidden = true

            }
        }
        
        if textField == signUpNickTextfield {
            AuthAPI.requestDuplicateCheck(flag: .nickname, input: signUpNickTextfield.text!) { json in
                if let json = json {
                    if json["data"].intValue == 0 {
                        self.nickCheck.isHidden = true
                    } else if json["data"].intValue == 1 {
                        self.nickCheck.isHidden = false
                        self.nickCheck.text = "중복된 닉네임"
                        self.nickCheck.textColor = UIColor.red
                    }
                } else {  }
            }
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

