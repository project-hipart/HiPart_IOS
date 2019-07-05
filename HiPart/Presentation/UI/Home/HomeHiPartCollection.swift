//
//  HomeHiPartCollection.swift
//  HiPart
//
//  Created by 최은희 on 04/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

struct HiPartCollection {
    var collectionImg: UIImage?
    var collectionTitle: String
    
    init(title: String, coverName: String) {
        self.collectionImg = UIImage(named: coverName)
        self.collectionTitle = title
    }
}
