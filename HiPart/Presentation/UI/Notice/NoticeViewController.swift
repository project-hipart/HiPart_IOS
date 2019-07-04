//
//  NoticeViewController.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeTable: UITableView!
    var noticeList: [NoticeTable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTable.delegate = self
        noticeTable.dataSource = self
        noticeTable.tableFooterView = UIView()
        
        setNoticeListData()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.hero.dismissViewController()
    }
}

extension NoticeViewController : UITableViewDelegate {
    
}

extension NoticeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = noticeTable.dequeueReusableCell(withIdentifier: "NoticeTableCell") as! NoticeTableCell
        
        let list = noticeList[indexPath.row]
    
        cell.noticeTitle.text = list.noticeTitle
        cell.noticeDate.text = list.noticeDate
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension NoticeViewController {
    func setNoticeListData() {
        let noticeListFirst = NoticeTable(title: "누군가가 하이파이브했습니다!", date: "19/12/12 15:35:45")
        let noticeListSecond = NoticeTable(title: "장소 협찬을 신청받았습니다.", date: "19/12/08 18:35:50")
        
        // 생성한 musicList 배열에 Music 모델들을 저장합니다.
        noticeList = [noticeListFirst, noticeListSecond]
    }
}
