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
	
	var isPortfolioView = false
	
	@IBOutlet var uploadIcon: UIImageView!
	@IBOutlet var youtubeLogo: UIImageView!
	@IBOutlet var afreecaLogo: UIImageView!
	@IBOutlet var twitchLogo: UIImageView!
	@IBOutlet var platformSelectImage: UIImageView!
	
	@IBOutlet var oneLineLabel: UILabel!
	@IBOutlet var wantLabel: UILabel!
	@IBOutlet var appealLabel: UILabel!
	
	@IBOutlet var scrollView: UIScrollView!
	
	var profile : ProfileDTO?
	var profileImage : UIImage?
	
	@IBOutlet var subscriberLabel: UILabel!
	@IBOutlet var hifiveLabel: UILabel!
	
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	var imageViewHeroId = ""
	@IBOutlet var uploadContainer: UIView!
	
	@IBOutlet var backButton: UIButton!
	@IBOutlet var filterStackView: UIStackView!
	private var filterViews : [FilterChip] = []
	
	private var uploadVideoViewController : PortfolioEditEmbedViewController?
	private var uploadTransViewController : PortfolioEditEmbedTransViewController?
}

extension HipartDetailViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupHero()
		self.setupView()
		self.setupBinding()
		
		if let profile = profile{
			setupUploadViewController(type : profile.type)
			viewModel.loadData(profile: profile)
		}
		
		
	}
	
	private func setupUploadViewController(type : UserType){
		
		debugE(#function, type)
		
		switch type{
		case .Translator:
			
			// Load Storyboard
			let storyboard = UIStoryboard(name: "HiPart", bundle: Bundle.main)
			
			// Instantiate View Controller
			let id = String(describing: PortfolioEditEmbedTransViewController.self)
			uploadTransViewController = storyboard.instantiateViewController(withIdentifier: id) as! PortfolioEditEmbedTransViewController
			
			// Add View Controller as Child View Controller
			self.add(asChildViewController: uploadTransViewController!, to: uploadContainer)
		default:
			
			// Load Storyboard
			let storyboard = UIStoryboard(name: "HiPart", bundle: Bundle.main)
			
			// Instantiate View Controller
			let id = String(describing: PortfolioEditEmbedViewController.self)
			uploadVideoViewController = storyboard.instantiateViewController(withIdentifier: id) as! PortfolioEditEmbedViewController
			
			// Add View Controller as Child View Controller
			self.add(asChildViewController: uploadVideoViewController!, to: uploadContainer)
		}
		
	}
}
extension HipartDetailViewController{
	private func setupHero(){
		self.hero.isEnabled=true
		self.imageView.hero.id = imageViewHeroId
		self.imageView.hero.modifiers = [.translate(),.scale(x: 2, y: 2, z: 1)]
	}
	private func setupView(){
		if !isPortfolioView{
			platformSelectImage.isHidden = true
			afreecaLogo.isHidden = true
			twitchLogo.isHidden = true
			
		}
		
		setPlatformImage()
		
		
		var filters : [Filter] = []
		
		if let profile = self.profile{
			
			if let filter = profile.broadcastConcept{
				filters.append(filter)
			}
			if let filter = profile.pd{
				filters.append(filter)
			}
			if let filter = profile.language{
				filters.append(filter)
			}
			if let filter = profile.etc{
				filters.append(filter)
			}
			Filter.sortWithUserType(&filters, type: profile.type)
			setFilters(filters,true)
			
			self.imageView.image = profileImage
			self.nicknameLabel.text = profile.nickname
			self.typeLabel.text = profile.type.name
			
			//		self.scrollView.contentInset = UIEdgeInsets.zero
			//		self.scrollView.contentSize = CGSize(width: Device.screenWidth, height: self.scrollView.contentSize.height)
			self.backButton.tintColor = UIColor.white
			self.imageView.cornerRadius = 75/2
			
			switch profile.type{
			case .Translator:
				uploadIcon.image = UIImage(named : "hipatTpatWorkAdotImg")
			default:
				break
			}
		}
	}
	private func setPlatformImage(){
		if let profile = self.profile{
			switch profile.platform{
			case .youtube:
				youtubeLogo.image = UIImage(named: "pofolYoutubeWhiteImg")
			case .afreeca:
				youtubeLogo.image = UIImage(named: "pofolAfreecaWhiteImg")
			case .twitch:
				youtubeLogo.image = UIImage(named: "pofolTwitchWhiteImg")
			default:
				break
			}
		}
	}
	
	private func setFilters(_ filters : [Filter],_ needFirstSelect : Bool){
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
		
		if needFirstSelect{
			self.filterStackView.addPaddingView()
		}
		
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
			oneLineLabel.text = detail.detailOneline
			wantLabel.text = detail.detailWant
			appealLabel.text = detail.detailAppeal
			
			
			if let profile = self.profile{
				
				switch profile.type{
				case .Translator:
					self.uploadTransViewController!.datas = UploadTrans.getArrayWithDatas(workIndexes: detail.workIndex, befores: detail.before, afters: detail.after)
				default:
					let datas = UploadVideo.getArrayWithDatas(workIndexes : detail.workIndex,thumbnails: detail.thumbnail, urls: detail.url, titles: detail.title, contents: detail.content)
					self.uploadVideoViewController!.datas = datas
				}
				
			}
			
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
