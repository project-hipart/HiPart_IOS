
import UIKit
import SnapKit

//import MaterialComponents.MaterialChips

class SearchCollectionViewCell: UICollectionViewCell {

	
	
//	@IBOutlet var platformStackView: UIStackView!
	@IBOutlet var platformImageView: UIImageView!
	@IBOutlet var thumbnailView: UIImageView!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var filterStackView: UIStackView!
	@IBOutlet var bodyLabel: UILabel!
	@IBOutlet var pickCountLabel: UILabel!
	private var filterViews : [FilterChip] = []
	
	@IBOutlet var pickButton: UIButton!
	private var picked : Bool = false{
		didSet{
			setPickButtonState(picked: picked)
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		setupView()
    }
	
	private func setupView(){
		self.layer.masksToBounds = false
		
		thumbnailView.cornerRadius = thumbnailView.frame.height/2
		nicknameLabel.adjustsFontSizeToFitWidth = true
		nicknameLabel.minimumScaleFactor = 0.5
		bodyLabel.adjustsFontSizeToFitWidth = true
		bodyLabel.minimumScaleFactor = 0.8
		self.filterStackView.spacing = 5
		
	}
	
	private func setupFilters(filters : [Filter], firstSelect : Bool){
		
		//REMOVE ALL CHIPS
		for button in filterViews{
			button.removeFromSuperview()
			self.filterStackView.removeArrangedSubview(button)
		}
		filterViews.removeAll()
		
		if let paddingView = self.filterStackView.arrangedSubviews.first as? UIView{
			paddingView.removeFromSuperview()
			self.filterStackView.removeArrangedSubview(paddingView)
		}
	
		for filter in filters{
			
			let filterView = FilterChip()
			
			filterView.translatesAutoresizingMaskIntoConstraints = false
			filterView.setChipTitle(filter.rawValue)
			
			self.filterViews.append(filterView)
			self.filterStackView.addArrangedSubview(filterView)
            
		}
		
		self.filterStackView.addPaddingView()
		
		if firstSelect{
        	select(0)
		}
	}
    
    private func select(_ index : Int){
        for i in 0..<filterViews.count{
            if i == index{
                filterViews[i].chipSelected = true
            }else{
                 filterViews[i].chipSelected = false
            }
        }
        
    }
	
	func setProfile(profile : ProfileDTO){
		thumbnailView.setImage(withUrl: profile.image)
		nicknameLabel.text = profile.nickname
		typeLabel.text = profile.type.name
		pickCountLabel.text = String(profile.pickCount)
		bodyLabel.text = profile.oneLine
		picked = profile.pickState.getPicked()
		
		switch profile.platform{
		case .none:
			break
		case .youtube:
			platformImageView.image = UIImage(named: "youtubeGreyImg")
		case .twitch:
			platformImageView.image = UIImage(named: "pofolTwitchGreyImg")
		case .afreeca:
			platformImageView.image = UIImage(named : "pofolAfreecaGreyImg")
			
		}
		
		
		var filterArray : [Filter] = []
		if let filter = profile.broadcastConcept{
			filterArray.append(filter)
		}
		if let filter = profile.pd{
			filterArray.append(filter)
		}
		if let filter = profile.language{
			filterArray.append(filter)
		}
		if let filter = profile.etc{
			filterArray.append(filter)
		}
		
		switch profile.type{
		case .Creator:
			filterArray = filterArray.filter{ filter in
				return filter.filterGroup != .BroadcastConcept
			}
			if let filter = profile.broadcastConcept{
				filterArray.insert(filter, at: 0)
				setupFilters(filters: filterArray,firstSelect: true)
			}else{
				setupFilters(filters: filterArray,firstSelect: false)
			}
		case .PD:
			filterArray = filterArray.filter{ filter in
				return filter.filterGroup != .PD
			}
			if let filter = profile.pd{
				filterArray.insert(filter, at: 0)
				setupFilters(filters: filterArray,firstSelect: true)
			}else{
				setupFilters(filters: filterArray,firstSelect: false)
			}
		case .Translator:
			filterArray = filterArray.filter{ filter in
				return filter.filterGroup != .Language
			}
			if let filter = profile.language{
				filterArray.insert(filter, at: 0)
				setupFilters(filters: filterArray,firstSelect: true)
			}else{
				setupFilters(filters: filterArray,firstSelect: false)
			}
		case .Etc:
			filterArray = filterArray.filter{ filter in
				return filter.filterGroup != .Etc
			}
			if let filter = profile.etc{
				filterArray.insert(filter, at: 0)
				setupFilters(filters: filterArray,firstSelect: true)
			}else{
				setupFilters(filters: filterArray,firstSelect: false)
			}
		default:
			break
		}
	}
	
	
	@IBAction func tapPickButton(_ sender: Any) {
		
		self.pickCountLabel.textColor = UIColor.mainPurple
		

		PickDialogView.showPickDialog()
		
		
		picked = !picked
		
	}
	
	private func setPickButtonState(picked : Bool){
		if picked{
			self.pickButton.setImage(UIImage(named: "mainPickOnIcon"),for: .normal)
			self.pickCountLabel.textColor = UIColor.mainPurple
		}else{
			self.pickButton.setImage(UIImage(named: "mainPickOffIcon"),for: .normal)
			self.pickCountLabel.textColor = UIColor.lightGray
		}
	}
	

	
}
