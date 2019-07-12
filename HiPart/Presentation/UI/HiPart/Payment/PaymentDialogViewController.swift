//
//  PaymentDialogViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//
import SwiftyJSON
import UIKit
import BEMCheckBox
import Hero

protocol PaymentDialogDelegate : NSObjectProtocol{
	func onTapContactButton(child : PaymentDialogViewController, success : Bool,number : String?,nickname : String?, type : UserType?,point : Int?)
}

class PaymentDialogViewController: UIViewController {
	@IBOutlet var blockView: UIView!
	@IBOutlet var okButton: UIButton!
	@IBOutlet var checkBox: BEMCheckBox!
	
	weak var delegate : PaymentDialogDelegate? = nil
	
	var profile : ProfileDetailDTO! = nil
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.checkBox.delegate = self
		self.hero.isEnabled = true

        // Do any additional setup after loading the view.
    }

	
	@IBAction func tapOkButton(_ sender: Any) {
		if checkBox.on{

			HifiveRepositoy.shared.contact(nickname: profile.userNickname){json in
				
				if let json = json{
					if json["success"].boolValue{
						
						HifiveRepositoy.shared.number(nickname: self.profile.userNickname){json in
							if let json = json{
								if json["success"].boolValue{
									
									let number = json["data"]["number"].stringValue
									let nickname = json["data"]["nickname"].stringValue
									let point = json["data"]["point"].intValue
									
									self.delegate?.onTapContactButton(child : self,success: true, number: number, nickname: nickname, type: self.profile.userType, point: point)
								}else{
									debugE("실패")
									self.delegate?.onTapContactButton(child : self,success: false, number: nil, nickname: nil, type: nil, point: nil)
								}
							}else{
								debugE("실패")
								self.delegate?.onTapContactButton(child : self,success: false, number: nil, nickname: nil, type: nil, point: nil)
							}
							
						}
						self.tapBackground(self)
					}else{
						debugE("실패")
						self.delegate?.onTapContactButton(child : self,success: false, number: nil, nickname: nil, type: nil, point: nil)
					}
				}else{
					debugE("err")
					self.delegate?.onTapContactButton(child : self,success: false, number: nil, nickname: nil, type: nil, point: nil)
				}
				
			}
		}else{
			debugE("실패")
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
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		if touch.view == blockView{
			return false
		}
		return true
	}
}

extension PaymentDialogViewController : BEMCheckBoxDelegate{
	
	@IBAction func tapBackground(_ sender: Any) {
		self.parent?.remove(asChildViewController: self)
	}
	
}
