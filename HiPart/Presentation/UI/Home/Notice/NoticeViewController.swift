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

        MainAPI.requestNotification { json in
            if let json = json {
                debugE(json)
                
                var cellTextData: String?
                
                if json["success"].boolValue {
                    
                    var result : [NoticeTable] = []
                    
                    for data in json["data"].arrayValue{
                        
                        let cellTextData : String
                        
                        switch data["type"].intValue{
                        case 1:
                            cellTextData = "\(data["content"].stringValue)님이 픽했습니다."
                        case 2:
                            cellTextData = "\(data["content"].stringValue)님이 하이파이브했습니다."
                        case 3:
                            cellTextData = "\(data["content"].stringValue)팜을 얻었습니다."
                        default:
                            fatalError()
                        }
                        
                        let notice = NoticeTable(
                                                 title: cellTextData,
                                                 date: data["createdAt"].stringValue)
                        result.append(notice)
                    }
                    
                    self.noticeList = result
                    self.noticeTable.reloadData()
                }else{
                    
                }
            }else{
                
            }
        }
    }
}
