//
//  PaymentDialogViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//
<<<<<<< HEAD

=======
import SwiftyJSON
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
import UIKit
import BEMCheckBox
import Hero

<<<<<<< HEAD
class PaymentDialogViewController: UIViewController {
	@IBOutlet var blockView: UIView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
=======

class PaymentDialogViewController: UIViewController {
	@IBOutlet var blockView: UIView!
	@IBOutlet var okButton: UIButton!
	@IBOutlet var checkBox: BEMCheckBox!
	
	var profile : ProfileDetailDTO! = nil
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.checkBox.delegate = self
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		self.hero.isEnabled = true

        // Do any additional setup after loading the view.
    }
    


	
<<<<<<< HEAD
}
extension PaymentDialogViewController : UIGestureRecognizerDelegate{
=======
	@IBAction func tapOkButton(_ sender: Any) {
		if checkBox.on{

			HifiveRepositoy.shared.contact(nickname: profile.userNickname){json in
				
				if let json = json{
					if json["success"].boolValue{
						debugE("성공")
						
						self.tapBackground(self)
					}else{
						debugE("실패")
					}
				}else{
					debugE("err")
				}
				
			}
		}else{
			
		}
	}
}


extension PaymentDialogViewController : UIGestureRecognizerDelegate{
	func didTap(_ checkBox: BEMCheckBox) {
		if checkBox.on{
			UIView.animate(withDuration: 0.5, animations: {[unowned self] in
			self.okButton.backgroundColor = UIColor.mainPurple
			self.okButton.isEnabled = true
			})
		}else{
			UIView.animate(withDuration: 0.5, animations: {[unowned self]  in
			self.okButton.backgroundColor = UIColor.lightGray
			self.okButton.isEnabled = false
			})
		}
	}
	
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		if touch.view == blockView{
			return false
		}
<<<<<<< HEAD
		
		
=======
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		return true
	}
}

extension PaymentDialogViewController : BEMCheckBoxDelegate{
	
<<<<<<< HEAD
	func didTap(_ checkBox: BEMCheckBox) {
		if checkBox.on{
			
		}else{
			
		}
	}
	
	@IBAction func tapBackground(_ sender: Any) {
//		self.hero.modalAnimationType = .selectBy(presenting: .none, dismissing: .none)
//		self.hero.dismissViewController()
		
=======
	
	@IBAction func tapBackground(_ sender: Any) {
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		self.parent?.remove(asChildViewController: self)
	}
	
}
