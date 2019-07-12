//
//  MasterViewModel.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation

class MasterViewModel {
    
    weak var delegate: MasterViewModelDelegate?
    var tabBarIndex: Int = 0 {
        didSet {
            delegate?.onTabChanged(num: tabBarIndex)
        }
    }
}

protocol MasterViewModelDelegate: AnyObject{
    func onTabChanged(num: Int)
}
