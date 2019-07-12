//
//  HomeCreaterViewController.swift
//  HiPart
//
//  Created by 최은희 on 03/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//
import UIKit
import Hero

class HomeCreaterViewController: UIViewController {
	
	@IBOutlet var collectionView: UICollectionView!
	
	
	private var datas : [ProfileDTO] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupDatas()
	}
	
	
	private func setupView(){
		let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: 325, height: 171)
		layout.minimumLineSpacing = 15
		
		layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
		

		self.collectionView.collectionViewLayout = layout
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
	}
	
	private func setupDatas(){
		ProfileRepository.shared.recommend{profiles in
			
			if let profiles = profiles{
				
				self.datas = profiles
				self.collectionView.reloadData()
			}else{
				debugE("에러")
			}
			
		}
	}
}
extension UICollectionView{
	
	func indexOfMajorCell(_ dataSource : [Any]) -> Int {
		let itemWidth = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width
		let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
		let index = Int(round(proportionalOffset))
		let safeIndex = max(0, min(dataSource.count - 1, index))
		return safeIndex
	}
}


extension HomeCreaterViewController : UICollectionViewDataSource,UICollectionViewDelegate{

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datas.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
		cell.contentView.borderColor = UIColor.mainGreen.withAlphaComponent(0.5)
		cell.contentView.cornerRadius = 6
		cell.contentView.borderWidth=1.3
		let item = datas[indexPath.row]
		cell.thumbnailView.hero.id = "asd\(indexPath.row)"
		cell.setProfile(profile: item)
		cell.delegate = self
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell{
			let item = datas[indexPath.row]
			self.navigateDetailViewController(myProfile: false, type: item.type, nickname: item.nickname, imageViewHeroId: cell.thumbnailView.hero.id ?? "",profileImage: cell.thumbnailView.image,pickState: item.pickState,pickCount : item.pickCount)
		}
	}
}

extension HomeCreaterViewController : SearchCollectionViewCellDelegate{
	func onChangePickState(profile : ProfileDTO,picked: Bool) {
		
		if let idx = datas.firstIndex(where : {p in p.nickname == profile.nickname}){
			let profile = datas[idx]
			profile.pickState = PickState.getPickedStateWithBool(picked)
			if picked{
				profile.pickCount += 1
			}else{
				profile.pickCount -= 1
			}
		}
	}
}

