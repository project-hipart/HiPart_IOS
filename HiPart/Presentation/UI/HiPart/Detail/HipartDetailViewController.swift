//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

<<<<<<< HEAD
=======
import SnapKit

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
class HipartDetailViewController: UIViewController {
	let viewModel = HiPartDetailViewModel()
	
	var isPortfolioView = false
	
<<<<<<< HEAD
=======
	@IBOutlet var uploadIcon: UIImageView!
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	@IBOutlet var youtubeLogo: UIImageView!
	@IBOutlet var afreecaLogo: UIImageView!
	@IBOutlet var twitchLogo: UIImageView!
	@IBOutlet var platformSelectImage: UIImageView!
	
	@IBOutlet var oneLineLabel: UILabel!
	@IBOutlet var wantLabel: UILabel!
	@IBOutlet var appealLabel: UILabel!
	
	@IBOutlet var scrollView: UIScrollView!
<<<<<<< HEAD
	
	var profile : ProfileDTO!
=======
	@IBOutlet var subscriberHeadLabel: UILabel!
	@IBOutlet var hifiveHeadLabel: UILabel!
	
	var profile : ProfileDetailDTO!
	//	var profile : ProfileDTO?
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	var profileImage : UIImage?
	
	@IBOutlet var subscriberLabel: UILabel!
	@IBOutlet var hifiveLabel: UILabel!
	
	@IBOutlet var typeLabel: UILabel!
<<<<<<< HEAD
	@IBOutlet var uploadContainerView: UIView!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	var imageViewHeroId = ""
=======
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	var imageViewHeroId = ""
	@IBOutlet var uploadContainer: UIView!
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	
	@IBOutlet var backButton: UIButton!
	@IBOutlet var filterStackView: UIStackView!
	private var filterViews : [FilterChip] = []
	
<<<<<<< HEAD
	private var embededViewController : PortfolioEditEmbedViewController!
=======
	@IBOutlet var portfolioBottomButtonContainer: UIView!
	@IBOutlet var cancelButton: UIButton!
	@IBOutlet var editButton: UIButton!
	@IBOutlet var contactButton: UIButton!
	
	private var uploadVideoViewController : PortfolioEditEmbedViewController?
	private var uploadTransViewController : PortfolioEditEmbedTransViewController?
	
	
	private  var platformIconTap : UITapGestureRecognizer {
		let tap = UITapGestureRecognizer()
		tap.delegate = self
		tap.addTarget(self, action: #selector(tapPlatformIcon(_:)))
		return tap
	}
	private  var subscriberTap : UITapGestureRecognizer {
		let tap = UITapGestureRecognizer()
		tap.delegate = self
		return tap
	}
}
extension HipartDetailViewController : UIGestureRecognizerDelegate{
	
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
}

extension HipartDetailViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
<<<<<<< HEAD
		self.setupHero()
		self.setupView()
		self.setupBinding()
		
		viewModel.loadData(profile: profile)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is PortfolioEditEmbedViewController{
			embededViewController = segue.destination as! PortfolioEditEmbedViewController
		}
	}
	
}
=======
		//		self.setupHero()
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

//MARK: Common Setups
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
extension HipartDetailViewController{
	private func setupHero(){
		self.hero.isEnabled=true
		self.imageView.hero.id = imageViewHeroId
<<<<<<< HEAD
		self.imageView.hero.modifiers = [.translate(),.scale(x: 2, y: 2, z: 1)]
	}
	private func setupView(){
=======
		self.imageView.hero.modifiers = [.translate()]
	}
	
	func setProfileDetail(profile : ProfileDetailDTO){
		self.profile = profile
	}
	
	
	private func setupView(){
		setupUploadViewController(type : profile.userType)
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		if !isPortfolioView{
			platformSelectImage.isHidden = true
			afreecaLogo.isHidden = true
			twitchLogo.isHidden = true
<<<<<<< HEAD
			
		}
		
		setPlatformImage()
		
		
		var filters : [Filter] = []
		
		if let filter = profile.broadcastConcept{
=======
		}
		if self.profileImage != nil{
			setupHero()
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
		
		if profile.userType != .Creator{
			self.subscriberLabel.isHidden = true
			self.subscriberHeadLabel.isHidden = true
			
			hifiveHeadLabel.snp.remakeConstraints{[unowned self] make in
				make.left.equalTo(self.imageView.snp.right).offset(14.5)
			}
		}
		
		//만약 포트폴리오에서 수정하는 화면이라면
		if isPortfolioView{
			self.portfolioBottomButtonContainer.isHidden = false
			self.cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
			self.editButton.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
			addTapTargets()
			
		}
			//디테일 화면에서 보는 것이라면
		else{
			self.contactButton.isHidden = false
			contactButton.addTarget(self, action: #selector(tapContactButton), for: .touchUpInside)
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
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			filters.append(filter)
		}
		if let filter = profile.pd{
			filters.append(filter)
		}
<<<<<<< HEAD
		if let filter = profile.language{
=======
		if let filter = profile.lang{
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			filters.append(filter)
		}
		if let filter = profile.etc{
			filters.append(filter)
		}
<<<<<<< HEAD
		Filter.sortWithUserType(&filters, type: profile.type)
		setFilters(filters,true)
		
		self.imageView.image = profileImage
		self.nicknameLabel.text = profile.nickname
		self.typeLabel.text = profile.type.name
		
		//		self.scrollView.contentInset = UIEdgeInsets.zero
		//		self.scrollView.contentSize = CGSize(width: Device.screenWidth, height: self.scrollView.contentSize.height)
		self.backButton.tintColor = UIColor.white
		self.imageView.cornerRadius = 75/2
		
		
	}
	private func setPlatformImage(){
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
=======
		Filter.sortWithUserType(&filters, type: profile.userType)
		setFilters(filters,true)
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
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
<<<<<<< HEAD

extension HipartDetailViewController : HiPartDetailViewModelDelegate{
	func onChangeProfileDetail(profileDetail: ProfileDetailDTO?) {
		
		if let detail = profileDetail{
			
			subscriberLabel.text = detail.detailSubscriber
			hifiveLabel.text = "\(detail.hifive)"
			oneLineLabel.text = detail.detailOneline
			wantLabel.text = detail.detailWant
			appealLabel.text = detail.detailAppeal
			
			embededViewController.datas = UploadVideo.getArrayWithDatas(thumbnails: detail.thumbnail, urls: detail.url, titles: detail.title, contents: detail.content)
		}
	}
=======
//MARK: Portfolio Edit Setups
extension HipartDetailViewController{
	private func addTapTargets(){
		self.youtubeLogo.addGestureRecognizer(self.platformIconTap)
		self.twitchLogo.addGestureRecognizer(self.platformIconTap)
		self.afreecaLogo.addGestureRecognizer(self.platformIconTap)
	}
	
	@objc private func tapPlatformIcon(_ tap : UITapGestureRecognizer){
		switch tap.view{
		case self.youtubeLogo:
			youtubeLogo.image = UIImage(named : "pofolYoutubeWhiteImg")
			afreecaLogo.image = UIImage(named : "")
			twitchLogo.image = UIImage(named : "")
		case self.afreecaLogo:
			youtubeLogo.image = UIImage(named : "")
			afreecaLogo.image = UIImage(named : "pofolAfreecaWhiteImg")
			twitchLogo.image = UIImage(named : "")
		case self.twitchLogo:
			youtubeLogo.image = UIImage(named : "")
			afreecaLogo.image = UIImage(named : "")
			twitchLogo.image = UIImage(named : "pofolTwitchWhiteImg")
		default:
			break
		}
	}
}

extension HipartDetailViewController : HiPartDetailViewModelDelegate{
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	
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
<<<<<<< HEAD
	@IBAction func tapContactButton(_ sender: Any) {
		
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PaymentDialogViewController.self))
=======
	
	///Cancel
	@objc private func tapCancelButton(){
		self.hero.dismissViewController()
	}
	///Edit
	@objc private func tapEditButton(){
		
	}
	
	///Contact
	@objc private func tapContactButton(_ sender: Any) {
		
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PaymentDialogViewController.self)) as! PaymentDialogViewController
		vc.profile = self.profile
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		
		self.add(asChildViewController: vc, to: self.view)
		//		self.present(vc, animated: false, completion: nil)
	}
}
<<<<<<< HEAD
=======

extension UIViewController{
	
	func navigateDetailViewController(myProfile : Bool,type : UserType, nickname : String?,imageViewHeroId : String = "", profileImage : UIImage? = nil ){
		
		
		//Portfolio
		if myProfile{
			switch type{
			case .Creator:
				
				PortfolioRepository.shared.creatorDetail{[unowned self]profileDetail in
					if let profileDetail = profileDetail{
						self.navigateDetailViewController(profileDetail: profileDetail,isPortfolioView : true)
						LoadingView.hideLoadingView()
					}else{
						debugE("error")
						LoadingView.hideLoadingView()
					}
				}
				
			case .PD:
				PortfolioRepository.shared.editorDetail{[unowned self]profileDetail in
					if let profileDetail = profileDetail{
						self.navigateDetailViewController(profileDetail: profileDetail,isPortfolioView : true)
						LoadingView.hideLoadingView()
					}else{
						debugE("error")
						LoadingView.hideLoadingView()
					}
				}
			case .Translator:
				PortfolioRepository.shared.translatorDetail{[unowned self]profileDetail in
					if let profileDetail = profileDetail{
						self.navigateDetailViewController(profileDetail: profileDetail,isPortfolioView : true)
						LoadingView.hideLoadingView()
					}else{
						debugE("error")
						LoadingView.hideLoadingView()
					}
				}
			case .Etc:
				PortfolioRepository.shared.etcDetail{[unowned self]profileDetail in
					if let profileDetail = profileDetail{
						self.navigateDetailViewController(profileDetail: profileDetail,isPortfolioView : true)
						LoadingView.hideLoadingView()
					}else{
						debugE("error")
						LoadingView.hideLoadingView()
					}
				}
			default:
				fatalError()
			}
			
		}
			//HipartDetail or HomeSearch
		else{
			
			ProfileRepository.shared.detail(nickname: nickname!, type: type){profileDetail in
				
				if let profileDetail = profileDetail{
					
					self.navigateDetailViewController(profileDetail: profileDetail, imageViewHeroId: imageViewHeroId, profileImage: profileImage)
					LoadingView.hideLoadingView()
				}else{
					LoadingView.hideLoadingView()
				}
				
				
			}
		}
		
	}
	
	fileprivate func navigateDetailViewController(profileDetail : ProfileDetailDTO, imageViewHeroId : String = "", profileImage : UIImage? = nil, isPortfolioView : Bool = false){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: String(describing: HipartDetailViewController.self)) as? HipartDetailViewController{
			vc.imageViewHeroId = imageViewHeroId
			vc.hero.modalAnimationType = .fade
			vc.isPortfolioView = isPortfolioView
			
			if let image = profileImage{
				vc.profileImage = image
			}
			
			vc.setProfileDetail(profile: profileDetail)
			self.present(vc, animated: true, completion: nil)
			
		}
	}
	
}

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
