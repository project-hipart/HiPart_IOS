//
//  HomeViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	@IBOutlet var stackView: UIStackView!
	@IBOutlet var cpatView: UIView!
	@IBOutlet var epatView: UIView!
	@IBOutlet var tpatView: UIView!
	@IBOutlet var etcView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		debugE(stackView.frame)
		debugE(cpatView.frame)
    }
	@IBAction func cpatTap(_ sender: Any) {
		navigateHiPartTab(0)
	}
	@IBAction func epatTap(_ sender: Any) {
		navigateHiPartTab(1)
	}
	@IBAction func tpatTap(_ sender: Any) {
		navigateHiPartTab(2)
	}
	@IBAction func etcpatTap(_ sender: Any) {
		navigateHiPartTab(3)
	}
	
	private func navigateHiPartTab(_ idx : Int){
		debugE(idx)
		let masterViewController = self.parent!.parent! as! MasterViewController
		let hipartViewControler = (masterViewController.getSelectedItem(1) as! UINavigationController).topViewController as! HiPartViewController
		
		masterViewController.setSelectedItem(index: 1)
		
		if hipartViewControler.tabLayout == nil{
			hipartViewControler.reservedTabIndex = idx + 1
		}else{
			hipartViewControler.tabLayout.selectedTab = idx + 1
		}
	}
}

extension HomeViewController : UIGestureRecognizerDelegate{
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
