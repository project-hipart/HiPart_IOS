//
//  MyPageViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var myPageListView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private lazy var myPageListVC : MyPageListViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "MyPage", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "MyPageListViewController") as! MyPageListViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController, to: myPageListView)
        
        return viewController
    }()

}
