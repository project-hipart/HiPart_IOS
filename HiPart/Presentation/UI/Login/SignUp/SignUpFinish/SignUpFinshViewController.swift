//
//  SignUpFinshViewController.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class SignUpFinshViewController: UIViewController {

    @IBOutlet weak var signUpFinishtBtn: EllipsePurpleLongBtn!
    @IBOutlet weak var signUpCollection: UICollectionView!
    
    var signUpCollecitonList: [SignUpFinishData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpFinishtBtn.setTitleColor(UIColor.white, for: .normal)

    }

}

extension SignUpFinshViewController: UICollectionViewDelegate {
    
}

extension SignUpFinshViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return signUpCollecitonList.count
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpFinishCell", for: indexPath) as! SignUpFinishCell
        
        let signUpCollection = signUpCollecitonList[indexPath.row]
        
        cell.signUpFinishTitle.text = signUpCollection.signUpCollectionTitle
        cell.signUpFinishSmallTitle.text = signUpCollection.signUpCollectionSmallTitle
        cell.signUpFinishImg.image = signUpCollection.signUpCollectionImg
        
        return cell
    }
}

extension SignUpFinshViewController {
    func setSignUpCollectionData() {
        
    }
    
//    signUpCollecitonList = []
}
