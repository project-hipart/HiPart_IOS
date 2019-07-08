//
//  LoginViewController.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

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
        
        self.navigationController?.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))

        idTextField.delegate = self
        pwTextField.delegate = self
     
    }
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == idTextField {
//            if string.count == 0 {
//                idView.borderColor = UIColor.middleGrey
//                idImg.image = UIImage(named: "loginIdOffIcon")
//            } else {
//                idView.borderColor = UIColor.mainPurple
//                idImg.image = UIImage(named: "loginIdOnIcon")
//            }
            if string.count > 0 {
                idView.borderColor = UIColor.mainPurple
                idImg.image = UIImage(named: "loginIdOnIcon")
            } else {
                idView.borderColor = UIColor.middleGrey
                idImg.image = UIImage(named: "loginIdOffIcon")
            }
        } else if textField == pwTextField {
            pwView.borderColor = UIColor.mainPurple
            pwImg.image = UIImage(named: "loginPasswordOnIcon")
        }
        return true
    }
}

