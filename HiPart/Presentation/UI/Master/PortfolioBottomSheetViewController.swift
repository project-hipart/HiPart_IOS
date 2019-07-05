//
//  PortfolioBottomSheetViewController.swift
//  HiPart
//
//  Created by 문명주 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class PortfolioBottomSheetViewController: UIViewController {
	
	@IBOutlet var bottomSheet: UIView!
	@IBOutlet var backgroundView: UIView!
	@IBOutlet var portfolioTap: UITapGestureRecognizer!
	@IBOutlet var todayUploadTap: UITapGestureRecognizer!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		slideUp()
        // Do any additional setup after loading the view.
		addBackgroundTapGestureRecognizer()
    }
	

	
}

//MARK: Setup
extension PortfolioBottomSheetViewController : UIGestureRecognizerDelegate{
	private func slideUp(){
		bottomSheet.transform = CGAffineTransform(translationX: 0, y: Device.tabBarHeight)
		
		UIView.animate(withDuration: 0.3){[unowned self] in
			self.bottomSheet.transform = CGAffineTransform(translationX: 0, y: -Device.tabBarHeight)
		}
	}
	
	private func addBackgroundTapGestureRecognizer(){
		self.view.isUserInteractionEnabled = true
		
	}
	
	
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		if gestureRecognizer == portfolioTap || gestureRecognizer == todayUploadTap{
			return false
		}
		return true
	}
}

//MARK: Actions
extension PortfolioBottomSheetViewController{
	@IBAction func tapPortfolio(_ sender: Any) {
		print(#function)
	}
	@IBAction func tapTodayUpload(_ sender: Any) {
		print(#function)
	}
	@IBAction func tapBackground(_ sender: Any) {
			print(#function)
			if let parent = self.parent{
				parent.remove(asChildViewController: self)
				parent.view.removeBlurView()
			}
	}
	
}
