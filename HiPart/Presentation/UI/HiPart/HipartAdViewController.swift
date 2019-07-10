//
//  HipotAdViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HipartAdViewController: UIViewController {

	@IBOutlet var collectionView: UICollectionView!
	
}

extension HipartAdViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupView()
	}
	
	private func setupView(){
		
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 310, height: 57)
		layout.minimumInteritemSpacing = 10
		layout.minimumLineSpacing = 10
//		layout.minimumLineSpacing=0
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
//		self.collectionView.isPagingEnabled = true
		self.collectionView.delegate=self
		self.collectionView.dataSource=self
		self.collectionView.collectionViewLayout = layout
		self.collectionView.showsHorizontalScrollIndicator=false
		self.collectionView.showsVerticalScrollIndicator=false
		
<<<<<<< HEAD
		self.view.backgroundColor = UIColor.black
=======
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	}
}
extension HipartAdViewController : UICollectionViewDataSource,UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HipartAdCollectionViewCell.self), for: indexPath) as? HipartAdCollectionViewCell{
		
			return cell
		}
		fatalError()
	}
	
	
}
extension HipartAdViewController{
	
}

