//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero
import SnapKit
class HipartDetailViewController: UIViewController {
	let viewModel = HiPartDetailViewModel()
	
	var isPortfolioView = false
	
	@IBOutlet var uploadIcon: UIImageView!
	@IBOutlet var youtubeLogo: UIImageView!
	@IBOutlet var afreecaLogo: UIImageView!
	@IBOutlet var twitchLogo: UIImageView!
	@IBOutlet var platformSelectImage: UIImageView!
	
	@IBOutlet var appealHead: UILabel!
	@IBOutlet var wantHead: UILabel!
	@IBOutlet var oneLineHead: UILabel!
	@IBOutlet var oneLineLabel: UILabel!
	@IBOutlet var wantLabel: UILabel!
	@IBOutlet var appealLabel: UILabel!
	
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var subscriberHeadLabel: UILabel!
	@IBOutlet var hifiveHeadLabel: UILabel!
	
	var profile : ProfileDetailDTO!
	var beforeProfile : ProfileDTO!
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
	
	@IBOutlet var portfolioBottomButtonContainer: UIView!
	@IBOutlet var cancelButton: UIButton!
	@IBOutlet var editButton: UIButton!
	@IBOutlet var contactButton: UIButton!
	@IBOutlet var pinButton: UIButton!
	@IBOutlet var pinLabel: UILabel!
	var pickState : PickState = .unPick
	var pickCount : Int = 0
	
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
		tap.addTarget(self, action: #selector(tapSubscriber(_:)))
		return tap
	}
	private var oneLineTap : UITapGestureRecognizer{
		let tap = UITapGestureRecognizer()
		tap.delegate = self
		tap.addTarget(self, action: #selector(tapOneLine(_:)))
		return tap
	}
	
	private var wantTap : UITapGestureRecognizer{
		let tap = UITapGestureRecognizer()
		tap.delegate = self
		tap.addTarget(self, action: #selector(tapWant(_:)))
		return tap
	}
	
	private var appealTap : UITapGestureRecognizer{
		let tap = UITapGestureRecognizer()
		tap.delegate = self
		tap.addTarget(self, action: #selector(tapAppeal(_:)))
		return tap
	}
	
}
extension HipartDetailViewController : UIGestureRecognizerDelegate{
	
}

extension HipartDetailViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
extension HipartDetailViewController{
	private func setupHero(){
		self.hero.isEnabled=true
		self.imageView.hero.id = imageViewHeroId
		self.imageView.hero.modifiers = [.translate()]
	}
	
	func setProfileDetail(profile : ProfileDetailDTO){
		self.profile = profile
	}
	
	
	private func setupView(){
		nicknameLabel.minimumScaleFactor = 0.7
		nicknameLabel.adjustsFontSizeToFitWidth = true
		setupUploadViewController(type : profile.userType)
		if !isPortfolioView{
			platformSelectImage.isHidden = true
			afreecaLogo.isHidden = true
			twitchLogo.isHidden = true
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
		self.nicknameLabel.sizeToFit()
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
			
			pinLabel.isHidden = true
			pinButton.isHidden = true
		}
			//디테일 화면에서 보는 것이라면
		else{
			
			self.contactButton.isHidden = false
			
			self.pinButton.addTarget(self, action: #selector(tapPinButton), for: .touchUpInside)
			if self.pickState.getPicked(){
				pinLabel.textColor = UIColor.mainPurple
				self.pinButton.setImage(UIImage(named : "pofolPickOnWhiteIcon"), for: .normal)
			}else{
				pinLabel.textColor = UIColor.white
				self.pinButton.setImage(UIImage(named : "pofolPickOffWhiteIcon"), for: .normal)
			}
			pinLabel.text = String(pickCount)
			
			
			
			if profile?.hifiveState == 1{
				self.contactButton.setTitle("하이파이브 완료", for: .normal)
				self.contactButton.cornerRadius = 6
				self.contactButton.isEnabled = false
				self.contactButton.backgroundColor = UIColor.lightGray
				
			}else{
				
				contactButton.addTarget(self, action: #selector(tapContactButton), for: .touchUpInside)
			}
			
		}
		
	}
	
	@objc private func tapPinButton(){
		LoadingView.showLoadingView()
		//선택되있는 상태라면
		if self.pickState.getPicked(){
			PickRepository.shared.pickDelete(nickname: profile.userNickname){bool in
				if let bool = bool{
					if bool{
						self.pinLabel.textColor = UIColor.white
						self.pinButton.setImage(UIImage(named : "pofolPickOffWhiteIcon"), for: .normal)
						let text = self.pinLabel.text!
						let int = Int(text)!
						self.pinLabel.text = String(int-1)
						
						self.pickState = .unPick
					}else{
						
					}
					
				}else{
					
				}
				LoadingView.hideLoadingView()
			}
		}
			//선택되있지 않다면
		else{
			PickRepository.shared.pickAdd(nickname: profile.userNickname){bool in
				if let bool = bool{
					
					if bool{
						self.pinLabel.textColor = UIColor.mainPurple
						self.pinButton.setImage(UIImage(named : "pofolPickOnWhiteIcon"), for: .normal)
						let text = self.pinLabel.text!
						let int = Int(text)!
						self.pinLabel.text = String(int+1)
						
						
						self.pickState = .pick
						
						PickDialogView.showPickDialog()
						
					}else{
						
					}
				}else{
					
				}
				LoadingView.hideLoadingView()
			}
		}
		
	}
	
	private func setPlatformImage(){
		if let profile = self.profile{
			switch profile.detailPlatform{
			case .youtube:
				youtubeLogo.image = UIImage(named: "pofolYoutubeWhiteImg")
			case .afreeca:
				afreecaLogo.image = UIImage(named: "pofolAfreecaWhiteImg")
			case .twitch:
				twitchLogo.image = UIImage(named: "pofolTwitchWhiteImg")
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
		
		for v in filterViews{
			self.filterStackView.removeArrangedSubview(v)
			v.removeFromSuperview()
		}
		
		for filter in filters{
			
			let view = FilterChip()
			view.translatesAutoresizingMaskIntoConstraints=false
			if needFirstSelect{
				view.chipSelected = filters[0] == filter
			}
			
			view.setChipTitle(filter.rawValue)
			view.setNeedsLayout()
			self.filterStackView.addArrangedSubview(view)
		}
		
		if isPortfolioView{
			self.addEditFilterButton(self.filterStackView)
		}
		
		self.filterStackView.addPaddingView()
		
	}
	
	private func addEditFilterButton(_ stackView : UIStackView){
		let view = FilterChip()
		view.translatesAutoresizingMaskIntoConstraints=false
		view.setChipTitle("필터 수정하기")
		view.borderColor = UIColor.lightGray
		view.label.textColor = UIColor.lightGray
		view.addTarget {[unowned self] in
			self.navigateEditFilter()
		}
		stackView.addArrangedSubview(view)
	}
	private func navigateEditFilter(){
		let sb = UIStoryboard(name: "Common", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: "PortfolioFilterEditViewController") as? PortfolioFilterEditViewController{
			vc.delegate = self
			vc.isMultiSelectorMode = true
			
			vc.selectedCreatorFilter = profile.concept
			vc.selectedEditorFilter = profile.pd
			vc.selectedTranslatorFilter = profile.lang
			vc.selectedEtcFilter = profile.etc
			
			vc.hero.isEnabled=true
			vc.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	private func setupBinding(){
		viewModel.delegate = self
	}
}

extension HipartDetailViewController : FilterChangeDelegate{
	func filterMultiChanged(filters: [Filter]) {
		self.profile.concept = nil
		self.profile.pd = nil
		self.profile.lang = nil
		self.profile.etc = nil
		
		let views = self.filterStackView.arrangedSubviews
		for v in views{
			self.filterStackView.removeArrangedSubview(v)
			v.removeFromSuperview()
		}
		
		for f in filters{
			switch f.filterGroup{
			case .BroadcastConcept:
				self.profile.concept = f
			case .PD:
				self.profile.pd = f
			case .Language:
				self.profile.lang = f
			case .Etc:
				self.profile.etc = f
			default:
				break
			}
		}
		debugE(filters)
		setFilters()
	}
	
	func filterChanged(filter: Filter?) {
		
	}
}

//MARK: Portfolio Edit Setups
extension HipartDetailViewController{
	private func addTapTargets(){
		self.youtubeLogo.addGestureRecognizer(self.platformIconTap)
		self.twitchLogo.addGestureRecognizer(self.platformIconTap)
		self.afreecaLogo.addGestureRecognizer(self.platformIconTap)
		self.wantHead.addGestureRecognizer(self.wantTap)
		self.wantLabel.addGestureRecognizer(self.wantTap)
		self.oneLineHead.addGestureRecognizer(self.oneLineTap)
		self.oneLineLabel.addGestureRecognizer(self.oneLineTap)
		self.appealHead.addGestureRecognizer(self.appealTap)
		self.appealLabel.addGestureRecognizer(self.appealTap)
		self.subscriberHeadLabel.addGestureRecognizer(self.subscriberTap)
		self.subscriberLabel.addGestureRecognizer(self.subscriberTap)
	}
	
	@objc private func tapPlatformIcon(_ tap : UITapGestureRecognizer){
		switch tap.view{
		case self.youtubeLogo:
			youtubeLogo.image = UIImage(named : "pofolYoutubeWhiteImg")
			afreecaLogo.image = UIImage(named : "pofolAfreecaWhiteOffImg")
			twitchLogo.image = UIImage(named : "pofolTwitchWhiteOffImg")
			self.profile.detailPlatform = .youtube
		case self.afreecaLogo:
			youtubeLogo.image = UIImage(named : "pofolYoutubeOffImg")
			afreecaLogo.image = UIImage(named : "pofolAfreecaWhiteImg")
			twitchLogo.image = UIImage(named : "pofolTwitchWhiteOffImg")
			self.profile.detailPlatform = .afreeca
		case self.twitchLogo:
			youtubeLogo.image = UIImage(named : "pofolYoutubeOffImg")
			afreecaLogo.image = UIImage(named : "pofolAfreecaWhiteOffImg")
			twitchLogo.image = UIImage(named : "pofolTwitchWhiteImg")
			self.profile.detailPlatform = .twitch
		default:
			break
		}
	}
	
	@objc private func tapSubscriber(_ tap : UITapGestureRecognizer){
		showEditAlertDialog("구독자 수정"){[unowned self] text in
			self.profile.detailSubscriber = text
			self.subscriberLabel.text = text
		}
	}
	@objc private func tapOneLine(_ tap : UITapGestureRecognizer){
		showEditAlertDialog("한 줄 소개"){[unowned self] text in
			self.profile.detailOneline = text
			self.oneLineLabel.text = text
		}
	}
	@objc private func tapWant(_ tap : UITapGestureRecognizer){
		showEditAlertDialog("이런 하이팟을 원해요"){[unowned self] text in
			self.profile.detailWant = text
			self.wantLabel.text = text
		}
	}
	@objc private func tapAppeal(_ tap : UITapGestureRecognizer){
		showEditAlertDialog("경력 수정"){[unowned self] text in
			self.profile.detailAppeal = text
			self.appealLabel.text = text
		}
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
	
	///Cancel
	@objc private func tapCancelButton(){
		self.hero.dismissViewController()
	}
	///Edit
	@objc private func tapEditButton(){
		LoadingView.showLoadingView()
		
		PortfolioRepository.shared.edit(edit: PortfolioAPI.edit(
			platform: self.profile.detailPlatform.rawValue,
			subscriber: self.profile.detailSubscriber,
			oneline: self.profile.detailOneline,
			want: self.profile.detailWant,
			appeal : self.profile.detailAppeal,
			concept: self.profile.concept?.intValue ?? 0,
			lang: self.profile.lang?.intValue ?? 0,
			pd: self.profile.pd?.intValue ?? 0,
			etc: self.profile.etc?.intValue ?? 0),completion: {[unowned self] json in
				if let json = json{
					if json["success"].boolValue{
						
						
						
						LoadingView.hideLoadingView()
						self.hero.dismissViewController()
					}else{
						
						LoadingView.hideLoadingView()
					}
				}else{
					
					LoadingView.hideLoadingView()
				}
		})
	}
	
	///Contact
	@objc private func tapContactButton(_ sender: Any) {
		
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PaymentDialogViewController.self)) as! PaymentDialogViewController
		vc.profile = self.profile
		vc.delegate = self
		self.add(asChildViewController: vc, to: self.view)
		//		self.present(vc, animated: false, completion: nil)
	}
	
	
	private func navigateContactViewController(number : String,nickname : String, type : UserType,point : Int){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: "ContactViewController") as? ContactViewController{
			
			vc.number = number
			vc.nickname = nickname
			vc.userType = type
			vc.point = point
			
			self.present(vc, animated: true, completion: nil)
		}
	}
}
extension HipartDetailViewController : PaymentDialogDelegate{
	func onTapContactButton(child : PaymentDialogViewController,success: Bool, number: String?, nickname: String?, type: UserType?, point: Int?) {
		if success{
			self.remove(asChildViewController: child)
			navigateContactViewController(number: number!, nickname: nickname!, type: type!, point: point!)
		}else{
			self.remove(asChildViewController: child)
		}
	}
}

extension UIViewController{
	
	func navigateDetailViewController(myProfile : Bool,type : UserType, nickname : String?,imageViewHeroId : String = "", profileImage : UIImage? = nil, pickState : PickState = PickState.unPick ,pickCount : Int = 0){
		
		
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
					
					self.navigateDetailViewController(profileDetail: profileDetail, imageViewHeroId: imageViewHeroId, profileImage: profileImage,pickState : pickState,pickCount : pickCount)
					LoadingView.hideLoadingView()
				}else{
					LoadingView.hideLoadingView()
				}
			}
		}
	}
	
	fileprivate func navigateDetailViewController(profileDetail : ProfileDetailDTO,
												  imageViewHeroId : String = "",
												  profileImage : UIImage? = nil,
												  isPortfolioView : Bool = false,
												  pickState : PickState = PickState.unPick,
												  pickCount : Int = 0){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: String(describing: HipartDetailViewController.self)) as? HipartDetailViewController{
			vc.imageViewHeroId = imageViewHeroId
			vc.hero.modalAnimationType = .fade
			vc.isPortfolioView = isPortfolioView
			vc.pickState = pickState
			vc.pickCount = pickCount
			
			
			if let image = profileImage{
				vc.profileImage = image
			}
			
			vc.setProfileDetail(profile: profileDetail)
			self.present(vc, animated: true, completion: nil)
			
		}
	}
	
}

