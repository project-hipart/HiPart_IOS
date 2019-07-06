//
//  PortfolioFilterEditViewController.swift
//  HiPart
//
//  Created by 문명주 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

protocol FilterChangeDelegate : NSObjectProtocol{
	func filterChanged(filters : [Filter])
}

class PortfolioFilterEditViewController: UIViewController {
	@IBOutlet var filterContainer: UIView!
	
	weak var delegate : FilterChangeDelegate? = nil
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

	@IBAction func tapBackground(_ sender: Any) {
		dismiss()
	}
	
}
extension PortfolioFilterEditViewController : UIGestureRecognizerDelegate{
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		if touch.view?.isDescendant(of: filterContainer) ?? false{
			return false
		}
		return true
	}
}

extension PortfolioFilterEditViewController{
	
	
	private func dismiss(){
		self.parent?.remove(asChildViewController: self)
	}
}
