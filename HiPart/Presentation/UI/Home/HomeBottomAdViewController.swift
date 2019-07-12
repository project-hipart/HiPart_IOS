//
//  HomeBottomAdViewController.swift
//  HiPart
//
//  Created by 최은희 on 12/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HomeBottomAdViewController: UIViewController {

	@IBOutlet var collectionView : UICollectionView!
	
	private let sampleDatas = ["mainAdOneImg",
							   "mainAdFivImg",
	"mainAdFoImg",
	"mainAdThrImg",
	"mainAdTwoImg"]
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupView()
    }
	
	private func setupView(){
		
		
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 310, height: 127)
		layout.minimumInteritemSpacing = 10
		layout.minimumLineSpacing = 15
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
//		self.collectionView.register(HomeBottomAdCollectionViewCell.self, forCellWithReuseIdentifier: "HomeBottomAdCollectionViewCell")
//		self.collectionView.isPagingEnabled = true
		self.collectionView.delegate=self
		self.collectionView.dataSource=self
		self.collectionView.collectionViewLayout = layout
		self.collectionView.showsHorizontalScrollIndicator=false
		self.collectionView.showsVerticalScrollIndicator=false
	}
}

extension HomeBottomAdViewController : UICollectionViewDelegate, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sampleDatas.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBottomAdCollectionViewCell", for: indexPath) as? HomeBottomAdCollectionViewCell{
			cell.imageView.image = UIImage(named: sampleDatas[indexPath.row])
			return cell
		}
		fatalError()
	}
	
	
}

