//
//  MyPageListViewController.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class MyPageListViewController: UIViewController {

    @IBOutlet weak var myPageTableView: UITableView!
    var myPageList: [MyPageList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyPageListData()
        
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        myPageTableView.isScrollEnabled = false
        myPageTableView.tableFooterView = UIView()
        
//        MyPageAPI.requestMyInfoView { json in
//            if let json = json {
//                let type = json["data"][APIKeys.userType].intValue
//                
//                switch type {
//                case 1:
//
//                case 2:
//                    return self.myPageMyPat.text = "편집자"
//                case 3:
//                    return self.myPageMyPat.text = "번역가"
//                case 4:
//                    return self.myPageMyPat.text = "기타"
//                default:
//                    break
//                }
//            }
//        }
    }
	
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = myPageTableView.indexPathForSelectedRow {
            myPageTableView.deselectRow(at: index, animated: true)
        }
    }
}

extension MyPageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
        if indexPath.row == 0 {
            let dvc = storyboard?.instantiateViewController(withIdentifier: "MyPagePick") as! MyPagePickViewController
            navigationController?.pushViewController(dvc, animated: true)
        } else if (indexPath.row == 1) || (indexPath.row == 2) || (indexPath.row == 3) {
            let alert = UIAlertController(title: "서비스 준비 중", message: "조금만 기다려주세요.", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .cancel) {
                (cancel) in
            }
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension MyPageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myPageTableView.dequeueReusableCell(withIdentifier: "MyPageListCell") as! MyPageListCell
        
        let list = myPageList[indexPath.row]
        
        cell.myPageListTitle.text = list.listTitle
        cell.myPageListImg.image = list.listImg
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        cell.selectedBackgroundView = bgColorView
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    
}

extension MyPageListViewController {
    func setMyPageListData() {
        let myPageListFirst = MyPageList(title: "마이 픽", coverName: "mypagePickGreyIcon")
        let myPageListSecond = MyPageList(title: "나랑 하이파이브한 사람", coverName: "mypageHifiveGreyIcon")
        let myPageListThird = MyPageList(title: "상세 포트폴리오 관리", coverName: "mypagePofolGreyIcon")
        let myPageListFourth = MyPageList(title: "1:1 문의", coverName: "mypageTalkGreyIcon")
        
        // 생성한 musicList 배열에 Music 모델들을 저장합니다.
        myPageList = [myPageListFirst, myPageListSecond, myPageListThird, myPageListFourth]
    }
}

