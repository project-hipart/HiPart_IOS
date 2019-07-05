//
//  PortfolioUploadViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class PortfolioUploadViewController: UIViewController {
	@IBOutlet var urlTextField: UITextField!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var titlleHeaderLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	
}
extension PortfolioUploadViewController{
	private func setupView(){
		self.urlTextField.addLeftPadding(16)
		titleLabel.setLineHeight(lineHeight: 1.5)
	}
}
extension UITextField{
	func addLeftPadding(_ padding : CGFloat){
		let view = UIView(frame:CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
		self.leftView = view
		self.leftViewMode = .always
	}
}
