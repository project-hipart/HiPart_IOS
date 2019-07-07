//
//  HomeHiPartViewController.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HomeHiPartViewController: UIViewController {
    
    @IBOutlet weak var hiPartCollectionView: UICollectionView!
    var hiPartCollection: [HiPartCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHiPartCollectionData()
        
        hiPartCollectionView.delegate = self
        hiPartCollectionView.dataSource = self
    }
}

extension HomeHiPartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension HomeHiPartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hiPartCollection.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHiPartCollectionCell", for: indexPath) as! HomeHiPartCollectionCell
        
        let collection = hiPartCollection[indexPath.row]
    
        cell.hiPartCollectionImg.image = collection.collectionImg
        cell.hiPartCollectionTitle.text = collection.collectionTitle
        
        return cell
    }
}

extension HomeHiPartViewController: UICollectionViewDelegateFlowLayout {

    // Collection View Cell 의 windth, height 를 지정할 수 있습니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

     let width: CGFloat = (view.frame.width ) / 4
     let height: CGFloat = view.frame.width

     return CGSize(width: width, height: height)
     }

    // minimumLineSpacingForSectionAt 은 수직 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
    
    // minimumInteritemSpacingForSectionAt 은 수평 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // insetForSectionAt 섹션 내부 여백을 말합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeHiPartViewController {
    func setHiPartCollectionData() {
        let hiCollectionFirst = HiPartCollection(title: "C-PAT", coverName: "mainCpotIcon")
        let hiCollectionSecond = HiPartCollection(title: "E-PAT", coverName: "mainEpotIcon")
        let hiCollectionThird = HiPartCollection(title: "T-PAT", coverName: "mainTpotIcon")
        let hiCollectionFourth = HiPartCollection(title: "ETC.", coverName: "mainEtcIcon")
        
        // 생성한 musicList 배열에 Music 모델들을 저장합니다.
        hiPartCollection = [hiCollectionFirst, hiCollectionSecond, hiCollectionThird, hiCollectionFourth]
    }
}


