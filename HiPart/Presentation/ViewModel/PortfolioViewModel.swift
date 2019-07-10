
//
//  Portfolio.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation

class PortfolioViewModel {

    weak var delegate: PortfolioViewModelDelegate?
    var labelText: String = ""{
        didSet {
            delegate?.onTextChanged(text: labelText)
        }
    }
}

protocol PortfolioViewModelDelegate: AnyObject{
    func onTextChanged(text : String)
}

