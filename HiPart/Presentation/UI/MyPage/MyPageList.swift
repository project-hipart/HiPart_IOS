//
//  MyPageList.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

struct MyPageList {
    var listImg: UIImage?
    var listTitle: String
    
    init(title: String, coverName: String) {
        self.listImg = UIImage(named: coverName)
        self.listTitle = title
    }
}
