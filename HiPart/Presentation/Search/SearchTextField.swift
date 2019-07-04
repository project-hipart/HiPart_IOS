//
//  SearchTextField.swift
//  MVVMRx
//
//  Created by 문명주 on 03/07/2019.
//  Copyright © 2019 storm. All rights reserved.
//

import UIKit

class SearchTextField : UITextField{
	
	weak var searchDelegate : SearchTextFieldDelegate?
	
	override init(frame : CGRect){
		super.init(frame : frame)
		
		commonInit()
	}
	required init?(coder : NSCoder){
		super.init(coder : coder)
		
		commonInit()
	}
	
	private func commonInit(){
		let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
		let rightIconImage = UIImage(named: "searchSearchIcon")
		let rightIconView = UIButton(frame:CGRect(x: 0, y: 0, width: 25.1, height : 15.1))
		rightIconView.contentMode = .left
		rightIconView.tintColor = UIColor.black
		rightIconView.setImage(rightIconImage, for: .normal)
		self.rightView = rightIconView
		self.rightViewMode = .always
		self.leftView = paddingView
		self.leftViewMode = .always
		self.placeholder = "원하는 검색어를 입력해주세요."
		
		self.cornerRadius = self.frame.height/2
		
		rightIconView.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
	}
	
	@objc private func tapSearchButton(){
		searchDelegate?.tapSearchButton()
	}
	
	
}

protocol SearchTextFieldDelegate : NSObjectProtocol{
	func tapSearchButton()
}
