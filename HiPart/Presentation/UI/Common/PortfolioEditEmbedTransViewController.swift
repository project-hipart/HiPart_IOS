//
//  PortfolioUploadViewController.swift
//  HiPart
//
//  Created by 최은희 on 06/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import SnapKit

class PortfolioEditEmbedTransViewController: UIViewController {
	@IBOutlet var noWorkingView: UIView!
	
	private lazy var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 174, height: 163)
		layout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25)
		layout.minimumInteritemSpacing = 20
		layout.scrollDirection = .horizontal
		let identifier = String(describing: PortfolioEditEmbedTransCollectionViewCell.self)
		let nib : UINib = UINib(nibName: identifier, bundle: nil)
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.showsHorizontalScrollIndicator = false
		view.register(nib, forCellWithReuseIdentifier: identifier)
		view.delegate=self
		view.dataSource=self
		view.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
		return view
	}()
	
	override func viewDidLoad() {
		
        super.viewDidLoad()
		self.setupView()
		self.setupLayout()

        // Do any additional setup after loading the view.
    }
	
	var datas : [UploadTrans] = []{
		didSet{
			if self.datas.isEmpty{
				self.noWorkingView.isHidden = false
			}else{
				self.noWorkingView.isHidden = true
			}
			self.collectionView.reloadData()
		}
	}

}
extension PortfolioEditEmbedTransViewController{
	private func setupView(){
		self.view.insertSubview(collectionView, at: 0)
	}
	private func setupLayout(){
		self.collectionView.snp.makeConstraints{[unowned self] make in
			make.center.equalTo(self.view.snp.center)
			make.width.height.equalTo(self.view)
		}
	}
}
extension PortfolioEditEmbedTransViewController : UICollectionViewDelegate{

}
extension PortfolioEditEmbedTransViewController : UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datas.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let item = datas[indexPath.row]
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PortfolioEditEmbedTransCollectionViewCell.self), for: indexPath) as? PortfolioEditEmbedTransCollectionViewCell{
			cell.uploadTrans = item
			return cell
		}
		fatalError()
	}
	
	
}
