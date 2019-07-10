//
//  SignUpFinishData.swift
//  HiPart
//
//  Created by 최은희 on 08/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

struct SignUpFinishData {
    var signUpCollectionTitle: String
    var signUpCollectionSmallTitle: String
    var signUpCollectionImg: UIImage?
    
    init(title: String, smallTitle: String, coverName: String) {
        self.signUpCollectionTitle = title
        self.signUpCollectionSmallTitle = smallTitle
        self.signUpCollectionImg = UIImage(named: coverName)
    }
}
