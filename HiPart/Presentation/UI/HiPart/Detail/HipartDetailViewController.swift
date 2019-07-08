//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class HipartDetailViewController: UIViewController {
	let viewModel = HiPartDetailViewModel()
	
	
	@IBOutlet var scrollView: UIScrollView!
	
	var profile : ProfileDTO!
	var profileImage : UIImage?
	
	@IBOutlet var subscriberLabel: UILabel!
	@IBOutlet var hifiveLabel: UILabel!
	
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var uploadContainerView: UIView!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	var imageViewHeroId = ""
	
	@IBOutlet var backButton: UIButton!
	@IBOutlet var filterStackView: UIStackView!
	private var filterViews : [FilterChip] = []
	
//
	
	
}

extension HipartDetailViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupHero()
		self.setupView()
		self.setFilters([Filter.ASMR])
		self.setupBinding()
		
		viewModel.loadData(profile: profile)
	}
	
}
extension HipartDetailViewController{
	private func setupHero(){
		self.hero.isEnabled=true
		self.imageView.hero.id = imageViewHeroId
		self.imageView.hero.modifiers = [.translate(),.scale(x: 2, y: 2, z: 1)]
	}
	private func setupView(){
		self.imageView.image = profileImage
		self.nicknameLabel.text = profile.nickname
		self.typeLabel.text = profile.type.name
		
//		self.scrollView.contentInset = UIEdgeInsets.zero
//		self.scrollView.contentSize = CGSize(width: Device.screenWidth, height: self.scrollView.contentSize.height)
		self.backButton.tintColor = UIColor.white
		self.imageView.cornerRadius = 75/2
		
		
	}
	private func setFilters(_ filters : [Filter]){
		//Remove all filterViews in StackView
		for v in filterViews{
			self.filterStackView.removeArrangedSubview(v)
			v.removeFromSuperview()
		}
		
		for filter in filters{
			let view = FilterChip()
			view.translatesAutoresizingMaskIntoConstraints=false
			view.chipSelected = filters[0] == filter
			
			view.setChipTitle(filter.rawValue)
			view.setNeedsLayout()
			
			self.filterStackView.addArrangedSubview(view)
		}
		
		
		self.filterStackView.addPaddingView()
		
	}
	private func setupBinding(){
		viewModel.delegate = self
	
	}
}

extension HipartDetailViewController : HiPartDetailViewModelDelegate{
	func onChangeProfileDetail(profileDetail: ProfileDetailDTO?) {
		
		if let detail = profileDetail{
			subscriberLabel.text = detail.detailSubscriber
			hifiveLabel.text = "\(detail.hifive)"
		}
	}
	
	func onChangeRefreshState(isRefreshing: Bool) {
		
	}
}

//MARK: Actions
extension HipartDetailViewController{
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@objc private func tapEditFilter(){
		
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PortfolioFilterEditViewController.self)){
			self.add(asChildViewController: vc, to: self.view)
		}
	}
	@IBAction func tapContactButton(_ sender: Any) {
		
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PaymentDialogViewController.self))
		
		self.add(asChildViewController: vc, to: self.view)
//		self.present(vc, animated: false, completion: nil)
	}
}
