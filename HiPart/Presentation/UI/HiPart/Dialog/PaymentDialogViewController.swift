//
//  PaymentDialogViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import BEMCheckBox
import Hero

class PaymentDialogViewController: UIViewController {
	@IBOutlet var blockView: UIView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.hero.isEnabled = true

        // Do any additional setup after loading the view.
    }
    


	
}
extension PaymentDialogViewController : UIGestureRecognizerDelegate{
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		if touch.view == blockView{
			return false
		}
		
		
		return true
	}
}

extension PaymentDialogViewController : BEMCheckBoxDelegate{
	
	func didTap(_ checkBox: BEMCheckBox) {
		if checkBox.on{
			
		}else{
			
		}
	}
	
	@IBAction func tapBackground(_ sender: Any) {
//		self.hero.modalAnimationType = .selectBy(presenting: .none, dismissing: .none)
//		self.hero.dismissViewController()
		
		self.parent?.remove(asChildViewController: self)
	}
	
}