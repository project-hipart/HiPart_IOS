//
//  SignUpFinshViewController.swift
//  HiPart
//
//  Created by 최은희 on 05/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpFinshViewController: UIViewController {

    @IBOutlet weak var signUpFinishtBtn: EllipsePurpleLongBtn!
    @IBOutlet weak var signUpCollection: UICollectionView!
    
    var loginText: Array<String> = []
    var loginImgData : Data!
    var loginImageUrl : NSURL!
    var loginPat: Int!
    var loginData: Data!
    var imageUrl : String!
    
    var signUpCollecitonList: [SignUpFinishData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpFinishtBtn.setTitleColor(UIColor.white, for: .normal)
        setSignUpCollectionData()
        
        signUpCollection.delegate = self
        signUpCollection.dataSource = self
    
    }
    
    @IBAction func upLoadSignUpData(_ sender: Any) {
        let email = loginText[0]
        let pw = loginText[1]
        let nick = loginText[2]
        let contact = loginText[3]
        
        AuthAPI.requestSignUp(email: email, nickname: nick, img: loginData, imageUrl: imageUrl, password: pw, number: contact, type: loginPat){json in
            if let json = json{
                if json["success"].boolValue {
                    self.performSegue(withIdentifier: "toSignUpSuccess", sender: self)
                    debugE("로그인성공")
                    //성공
                } else {
                    debugE("로그인 실패")
                }
            }else{
                debugE("통신 오류")
            }
            
        }
    }
    
}


extension SignUpFinshViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell?.borderColor == UIColor.mainPurple{
            cell?.borderColor = UIColor.lightGrey
        } else {
            collectionView.visibleCells.forEach { cell in
                cell.borderColor = UIColor.lightGrey
            }
             cell?.borderColor = UIColor.mainPurple
             loginPat = indexPath.row + 1
             print(loginPat!)
        }
    }
}


extension SignUpFinshViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return signUpCollecitonList.count
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpFinishCell", for: indexPath) as! SignUpFinishCell
        
        let collection = signUpCollecitonList[indexPath.row]
        
        cell.signUpFinishTitle.text = collection.signUpCollectionTitle
        cell.signUpFinishSmallTitle.text = collection.signUpCollectionSmallTitle
        cell.signUpFinishImg.image = collection.signUpCollectionImg
        
        return cell
    }
}


extension SignUpFinshViewController: UICollectionViewDelegateFlowLayout {

    // minimumLineSpacingForSectionAt 은 수직 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    // minimumInteritemSpacingForSectionAt 은 수평 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


extension SignUpFinshViewController {
    func setSignUpCollectionData() {
        let cpat = SignUpFinishData(title: "C-PAT", smallTitle: "(크리에이터)", coverName: "mainCpotIcon")
        let epat = SignUpFinishData(title: "E-PAT", smallTitle: "(편집자)", coverName: "mainEpotIcon")
        let tpat = SignUpFinishData(title: "T-PAT", smallTitle: "(번역가)", coverName: "mainTpotIcon")
        let etc = SignUpFinishData(title: "ETC.", smallTitle: "(기타)", coverName: "mainEtcIcon")
        
        signUpCollecitonList = [cpat, epat, tpat, etc]
    }
}

