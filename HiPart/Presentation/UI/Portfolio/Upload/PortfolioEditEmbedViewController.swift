//
//  PortfolioUploadViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class PortfolioEditEmbedViewController: UIViewController {

	@IBOutlet var collectionView: UICollectionView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupView()

        // Do any additional setup after loading the view.
    }
	

}
extension PortfolioEditEmbedViewController{
	private func setupView(){
		let identifier = String(describing: PortfolioEditEmbedCollectionViewCell.self)
		let nib = UINib(nibName: identifier, bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: identifier)
		
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 175, height: 163)
		layout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25)
//		layout.
		layout.minimumInteritemSpacing = 15
		layout.scrollDirection = .horizontal
		
		self.collectionView.collectionViewLayout = layout
		self.collectionView.delegate=self
		self.collectionView.dataSource=self
	}
}
extension PortfolioEditEmbedViewController : UICollectionViewDelegate{

}
extension PortfolioEditEmbedViewController : UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 40
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PortfolioEditEmbedCollectionViewCell.self), for: indexPath) as? PortfolioEditEmbedCollectionViewCell{
			print(cell)
			return cell
		}
		fatalError()
	}
	
	
}
