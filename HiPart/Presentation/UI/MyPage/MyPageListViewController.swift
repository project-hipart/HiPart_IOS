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
    }
}

extension MyPageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
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
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    
}

extension MyPageListViewController {
    func setMyPageListData() {
        let myPageListFirst = MyPageList(title: "마이 픽", coverName: "mypagePickGreyIcon")
        let myPageListSecond = MyPageList(title: "나랑 하이파이브한 사람", coverName: "mypagePofolGreyIcon")
        let myPageListThird = MyPageList(title: "상세 포트폴리오 관리", coverName: "mypagePofolGreyIcon")
        let myPageListFourth = MyPageList(title: "1:1 문의", coverName: "mypageTalkGreyIcon")
        
        // 생성한 musicList 배열에 Music 모델들을 저장합니다.
        myPageList = [myPageListFirst, myPageListSecond, myPageListThird, myPageListFourth]
    }
}

