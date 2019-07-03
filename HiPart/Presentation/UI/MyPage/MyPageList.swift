//
//  MyPageList.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

// Music 모델입니다.
// 멤버 변수가 총 세 개인 Music 구조체를 생성했습니다.
struct MyPageList {
    var listImg: UIImage?
    var listTitle: String
    
    init(title: String, coverName: String) {
        self.listImg = UIImage(named: coverName)
        self.listTitle = title
    }
}
