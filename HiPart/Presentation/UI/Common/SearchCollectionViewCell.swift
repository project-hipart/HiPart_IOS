
import UIKit
import SnapKit

//import MaterialComponents.MaterialChips

class SearchCollectionViewCell: UICollectionViewCell {

//	@IBOutlet var platformStackView: UIStackView!
	@IBOutlet var thumbnailView: UIImageView!
	@IBOutlet var nicknameLabel: UILabel!
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var filterStackView: UIStackView!
	@IBOutlet var bodyLabel: UILabel!
	@IBOutlet var pickCountLabel: UILabel!
	private var filterViews : [FilterChip] = []
	
	@IBOutlet var pickButton: UIButton!
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
		
		setupFilters(filters: ["먹방","먹방","+더보기asdasd"])
	}
	
	private func setupFilters(filters : [String]){
		
		//REMOVE ALL CHIPS
		for button in filterViews{
			button.removeFromSuperview()
			self.filterStackView.removeArrangedSubview(button)
		}
	
		for filter in filters{
			let filterView = FilterChip()
			filterView.translatesAutoresizingMaskIntoConstraints = false
			filterView.setChipTitle(filter)
			
			self.filterViews.append(filterView)
			self.filterStackView.addArrangedSubview(filterView)
            
		}
		
		self.filterStackView.addPaddingView()
        
        select(0)
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
	
	@IBAction func tapPickButton(_ sender: Any) {
		self.pickButton.setImage(UIImage(named: "mainPickOnIcon"),for: .normal)
		self.pickCountLabel.textColor = UIColor.mainPurple
		
		let pickedView = PickDialogView()
		
		let window = UIApplication.shared.keyWindow
		window?.addSubview(pickedView)
		
		pickedView.snp.makeConstraints{[weak window] make in
			make.center.equalTo(window!.snp.center)
			make.width.equalTo(110)
			make.height.equalTo(110+15+28)
		}
		
		UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
			pickedView.alpha = 0
		}, completion: {[unowned pickedView] animated in
			pickedView.removeFromSuperview()
		})
	}
	

}
