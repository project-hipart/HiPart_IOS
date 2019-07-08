//
//  HomeViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hiPartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
//    private lazy var hiCollectionVC : HomeHiPartViewController = {
//        // Load Storyboard
//        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
//
//        // Instantiate View Controller
//        var viewController = storyboard.instantiateViewController(withIdentifier: "HomeHiPartViewController") as! HomeHiPartViewController
//
//        // Add View Controller as Child View Controller
//        self.add(asChildViewController: viewController, to: hiPartView)
//
//        return viewController
//    }()

}
