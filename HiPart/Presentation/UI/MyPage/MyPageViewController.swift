//
//  MyPageViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero
import SwiftyJSON

class MyPageViewController: UIViewController {

    @IBOutlet weak var myPageListView: UIView!
    @IBOutlet weak var myPageImg: RoundImg!
    @IBOutlet weak var myPageMyName: UILabel!
    @IBOutlet weak var myPageMyPat: UILabel!
    @IBOutlet weak var myPickedLabel: UILabel!
    @IBOutlet weak var myHiFiveLabel: UILabel!
    @IBOutlet weak var myPam: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingView.showLoadingView()
        MyPageAPI.requestMyPageView { json in
            if let json = json {
                let url = json["data"][APIKeys.userImage].stringValue
                let myName = json["data"][APIKeys.userNickname].stringValue
                let myPat = json["data"][APIKeys.detailFlatform].intValue
                let myHiFive = json["data"][APIKeys.hifive].intValue
                let myPick = json["data"][APIKeys.pick].intValue
                let myPoint = json["data"]["point"].intValue
                
                if json["success"].boolValue {
                    self.myPageImg.setImage(withUrl: url){
                        LoadingView.hideLoadingView()
                    }
                    self.myPageMyName.text = myName
                    
                    self.myPickedLabel.text = "\(myPick)"
                    self.myHiFiveLabel.text = "\(myHiFive)"
                    self.myPam.text = "\(myPoint)"
                    
                    switch myPat {
                    case 0:
                        return self.myPageMyPat.text = "크리에이터"
                    case 1:
                        return self.myPageMyPat.text = "편집자"
                    case 2:
                        return self.myPageMyPat.text = "번역가"
                    case 3:
                        return self.myPageMyPat.text = "기타"
                    default:
                        break
                    }
                }else{
                    LoadingView.hideLoadingView()
                }
            }else{
                LoadingView.hideLoadingView()
            }
        }
    }
    
    @IBAction func goSettingBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "MyPageSetting", bundle: nil)
        let dvc = sb.instantiateViewController(withIdentifier: "MyPageSettingViewController") as! MyPageSettingViewController
        
        dvc.hero.isEnabled = true
        dvc.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))
        
        present(dvc, animated: true)
    }
    
}
