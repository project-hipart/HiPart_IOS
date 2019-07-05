//
//  SignUpViewController.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpNextBtn: EllipsePurpleLongBtn!
    @IBOutlet weak var myImg: RoundImg!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpNextBtn.setTitleColor(UIColor.white, for: .normal)

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
