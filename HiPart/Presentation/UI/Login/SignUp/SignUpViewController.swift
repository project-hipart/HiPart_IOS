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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpNextBtn.setTitleColor(UIColor.white, for: .normal)
    }

}
