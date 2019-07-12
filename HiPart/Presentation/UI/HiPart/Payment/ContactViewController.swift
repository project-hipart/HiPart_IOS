//
//  ContactViewController.swift
//  HiPart
//
//  Created by 최은희 on 11/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class ContactViewController: UIViewController {

	var nickname : String!
	var userType : UserType!
	var point : Int!
	var number : String!
	
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var pointLabel: UILabel!
	@IBOutlet var numberLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
        // Do any additional setup after loading the view.
    }
	
	private func setupView(){
		switch self.userType! {
		case .Creator:
			self.typeLabel.text = "C-PAT"
		case .PD:
			self.typeLabel.text = "E-PAT"
		case .Translator:
			self.typeLabel.text = "T-PAT"
		case .Etc:
			self.typeLabel.text = "ETC."
		default:
			self.typeLabel.text = ""
		}
		
		self.nicknameLabel.text = self.nickname
		self.pointLabel.text = "남은 팜 \(self.point!)개"
		self.numberLabel.text = self.number
	}
    

	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	
	@IBAction func tapCopyButton(_ sender: Any) {
		let pasteBoard = UIPasteboard.general
		pasteBoard.string = self.number
	}
}
