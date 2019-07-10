//
//  PatModifyViewController.swift
//  HiPart
//
//  Created by 최은희 on 11/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class PatModifyViewController: UIViewController {

    @IBOutlet weak var patModifyCollection: UICollectionView!
    
    var patModifyCollectionList: [PatModifySetData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPatData()
        
        patModifyCollection.delegate = self
        patModifyCollection.dataSource = self

    }

}

extension PatModifyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return patModifyCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patModifyCell", for: indexPath) as! PatModifyCollectionCell
        
        let collection = patModifyCollectionList[indexPath.row]
        
        cell.patModifyLabel.text = collection.patModifyTitle
        
        return cell
    }
}

extension PatModifyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell?.borderColor == UIColor.mainPurple {
            cell?.borderColor = UIColor.lightGrey
        } else {
            collectionView.visibleCells.forEach { cell in
                cell.borderColor = UIColor.lightGrey
            }
            cell?.borderColor = UIColor.mainPurple
        }
    }
}

extension PatModifyViewController {
    func setPatData() {
        let cpat = PatModifySetData(title: "C-PAT")
        let epat = PatModifySetData(title: "E-PAT")
        let tpat = PatModifySetData(title: "T-PAT")
        let etc = PatModifySetData(title: "ETC.")
        
        patModifyCollectionList = [cpat, epat, tpat, etc]
    }
}
