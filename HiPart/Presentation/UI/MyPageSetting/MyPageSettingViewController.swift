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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled=true
        self.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bacnBtn(_ sender: UIButton) {
        self.hero.dismissViewController()
    }
}
