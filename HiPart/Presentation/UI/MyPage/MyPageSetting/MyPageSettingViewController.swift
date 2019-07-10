//
//  MyPageSettingViewController.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class MyPageSettingViewController: UIViewController {

    @IBOutlet weak var myPageImg: RoundImg!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled=true
        self.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.hero.dismissViewController()
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
<<<<<<< HEAD
        if let possibleImage = info[.editedImage] as? UIImage {
            self.myPageImg.image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            self.myPageImg.image = possibleImage
        } else {
            return
        }
        picker.dismiss(animated: true)
=======
        if let possibleImage = info[.editedImage] as? RoundImg {
            self.myPageImg = possibleImage
        } else if let possibleImage = info[.originalImage] as? RoundImg {
            self.myPageImg = possibleImage
        } else {
            return
        }
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
<<<<<<< HEAD
    
=======
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
}
