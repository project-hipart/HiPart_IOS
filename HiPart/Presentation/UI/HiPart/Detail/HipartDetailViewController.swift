//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero
import RxSwift

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
	
	var profile : ProfileDetailDTO!
	//	var profile : ProfileDTO?
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
		
		
		
		
	}
	
	private func setupUploadViewController(type : UserType){
		
		
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
	
	func setProfileDetail(profile : ProfileDetailDTO){
		self.profile = profile
	}
	
	
	private func setupView(){
		setupUploadViewController(type : profile.userType)
		if !isPortfolioView{
			platformSelectImage.isHidden = true
			afreecaLogo.isHidden = true
			twitchLogo.isHidden = true
		}
		if self.profileImage != nil{
			self.imageView.image = self.profileImage!
		}else{
			self.imageView.setImage(withUrl: profile.userImg)
		}
		setPlatformImage()
		setFilters()
		self.nicknameLabel.text = profile.userNickname
		self.typeLabel.text = profile.userType.name
		switch profile.userType{
		case .Translator:
			uploadIcon.image = UIImage(named : "hipatTpatWorkAdotImg")
		default:
			break
		}
		
		self.imageView.cornerRadius = 75/2
		
		subscriberLabel.text = profile.detailSubscriber
		hifiveLabel.text = "\(profile.hifive)"
		oneLineLabel.text = profile.detailOneline
		wantLabel.text = profile.detailWant
		appealLabel.text = profile.detailAppeal
		
		
		
		switch profile.userType{
		case .Translator:
			self.uploadTransViewController!.datas = UploadTrans.getArrayWithDatas(workIndexes: profile.workIndex, befores: profile.before, afters: profile.after)
		default:
			let datas = UploadVideo.getArrayWithDatas(workIndexes : profile.workIndex,thumbnails: profile.thumbnail, urls: profile.url, titles: profile.title, contents: profile.content)
			self.uploadVideoViewController!.datas = datas
		}
		
	}
	private func setPlatformImage(){
		if let profile = self.profile{
			switch profile.detailPlatform{
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
	private func setFilters(){
		var filters : [Filter] = []
		
		
		if let filter = profile.concept{
			filters.append(filter)
		}
		if let filter = profile.pd{
			filters.append(filter)
		}
		if let filter = profile.lang{
			filters.append(filter)
		}
		if let filter = profile.etc{
			filters.append(filter)
		}
		Filter.sortWithUserType(&filters, type: profile.userType)
		setFilters(filters,true)
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

extension UIViewController{
	
	func navigateDetailViewController(myProfile : Bool,type : UserType, nickname : String?,imageViewHeroId : String = "", profileImage : UIImage? = nil ){
		//		LoadingView.showLoadingView()
		
		let profileSingle : Single<ProfileDetailDTO>
		
		//Portfolio
		if myProfile{
			switch type{
			case .Creator:
				profileSingle = PortfolioRepository.shared.creatorDetail()
			case .PD:
				profileSingle = PortfolioRepository.shared.editorDetail()
			case .Translator:
				profileSingle = PortfolioRepository.shared.translatorDetail()
			case .Etc:
				profileSingle = PortfolioRepository.shared.etcDetail()
			default:
				fatalError()
			}
			
			profileSingle.subscribe(onSuccess: {[unowned self] profileDetail in
				
				self.navigateDetailViewController(profileDetail: profileDetail)
				LoadingView.hideLoadingView()
				
				}, onError: {err in
					debugE(err)
					LoadingView.hideLoadingView()
					
			})
			
		}
			//HipartDetail or HomeSearch
		else{
			
			ProfileRepository.shared.detail(nickname: nickname!, type: type)
				.subscribe(onSuccess: {[unowned self]  profileDetail in
					
					self.navigateDetailViewController(profileDetail: profileDetail, imageViewHeroId: imageViewHeroId, profileImage: profileImage)
					LoadingView.hideLoadingView()
					
					}, onError: {err in
						debugE(err)
						LoadingView.hideLoadingView()
				})
		}
	}
	
	fileprivate func navigateDetailViewController(profileDetail : ProfileDetailDTO, imageViewHeroId : String = "", profileImage : UIImage? = nil){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: String(describing: HipartDetailViewController.self)) as? HipartDetailViewController{
			vc.imageViewHeroId = imageViewHeroId
			vc.hero.modalAnimationType = .fade
			
			if let image = profileImage{
				vc.profileImage = image
			}
			
			vc.setProfileDetail(profile: profileDetail)
			self.present(vc, animated: true, completion: nil)
			
		}
	}
	
}

