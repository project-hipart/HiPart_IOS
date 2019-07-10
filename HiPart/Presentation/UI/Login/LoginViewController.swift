//
//  LoginViewController.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var idImg: UIImageView!
    @IBOutlet weak var pwImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.setTitleColor(UIColor.white, for: .normal)

        idTextField.delegate = self
        pwTextField.delegate = self
     
        loginBtn.backgroundColor = UIColor.lightGrey
        loginBtn.isEnabled = false
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        AuthAPI.requestSignIn(email: idTextField.text ?? "", password : pwTextField.text ?? "")
            .subscribe(onSuccess: {(json : JSON) in
                
                if json["success"].boolValue {
                    let token = json["data"]["tokens"]["token"].stringValue
                    TokenHelper.saveAccessToken(token: token)
                    self.performSegue(withIdentifier: "toLoginSuccess", sender: self)
                    //성공
                } else {
                    let alert = UIAlertController(title: "로그인 실패", message: "다시 시도해주세요.", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "확인", style: .cancel) {
                        (cancel) in
                    }
                    alert.addAction(confirm)
                    self.present(alert, animated: true, completion: nil)

                    debugE("로그인 실패")
                }
            }, onError: { err in
                //  에러남
                
            })
    }
    
}

extension LoginViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        if textField == idTextField {
            if newString.length == 0 {
                idView.borderColor = UIColor.lightGrey
                idImg.image = UIImage(named: "loginIdOffIcon")
                
            } else {
                idView.borderColor = UIColor.mainPurple
                idImg.image = UIImage(named: "loginIdOnIcon")
            }
        }
        
        else if textField == pwTextField {
            if newString.length == 0 {
                pwView.borderColor = UIColor.lightGrey
                pwImg.image = UIImage(named: "loginPasswordOffIcon")
            } else {
                pwView.borderColor = UIColor.mainPurple
                pwImg.image = UIImage(named: "loginPasswordOnIcon")
            }
        }
        
        
        if pwView.borderColor == UIColor.mainPurple && idView.borderColor == UIColor.mainPurple {
            self.loginBtn.backgroundColor = UIColor.mainPurple
            self.loginBtn.isEnabled = true
        } else {
            self.loginBtn.backgroundColor = UIColor.lightGrey
            self.loginBtn.isEnabled = false
        }

        
        
        return true
    }
}
