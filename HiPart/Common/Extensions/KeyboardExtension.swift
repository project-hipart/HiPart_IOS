//
//  KeyboardExtension.swift
//  HiPart
//
//  Created by 최은희 on 13/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

func addKeyboardNotification(_ observer : Any, _ willShow : Selector, _ willHide : Selector){
	NotificationCenter.default.addObserver(observer, selector: willShow, name: UIResponder.keyboardWillShowNotification, object: nil)
	NotificationCenter.default.addObserver(observer, selector: willHide, name: UIResponder.keyboardWillHideNotification, object: nil)
}

