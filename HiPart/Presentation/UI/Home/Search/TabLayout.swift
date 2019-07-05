
import UIKit
import SnapKit

protocol TabLayoutDelegate : NSObjectProtocol{
	func onSelectedTab(_ index : Int)
}

class TabLayout : UIView{
	
	weak var delegate : TabLayoutDelegate?
	var primaryColor : UIColor =  UIColor.init(red : 121/255, green : 71/255, blue : 253/255, alpha :1.0)
	var defaultColor : UIColor = UIColor.init(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0)
	
	private lazy var tabLayout : UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.distribution = UIStackView.Distribution.fill
		view.spacing = 20
		view.alignment = UIStackView.Alignment.center
		return view
	}()
	
	
	private let tabTitles : [String] = ["전체","C-PAT","E-PAT","T-PAT","ETC."]
	private var tabViews : [UIButton] = []
	
	private var selectedTab : Int = 0{
		didSet{
			changeTabColor(selected: selectedTab)
			moveTabIndicator(selected: selectedTab)
			delegate?.onSelectedTab(selectedTab)
		}
	}
	
	private lazy var tabStripIndicatorBackground : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(red: 228/255, green: 228/255, blue: 228/255, alpha: 28/100)
		return view
	}()
	private lazy var tabStripIndicator : UIView = {
		let view = UIView()
		view.backgroundColor = self.primaryColor
		
		return view
	}()
	
	override init(frame : CGRect){
		super.init(frame : frame)
		
		commonInit()
	}
	required init?(coder : NSCoder){
		super.init(coder : coder)
		
		commonInit()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
//		moveTabIndicator(selected: 0)
		let button = tabViews[0]
		let originalFrame = self.tabStripIndicator.frame
		self.tabStripIndicator.frame = CGRect(x: button.frame.origin.x, y: originalFrame.origin.y, width: button.frame.width, height: originalFrame.height)
	}
	
	private func commonInit(){
		setupView()
		setupLayout()
		
		
		for title in tabTitles{
			let button = makeTabItem(title: title)
			tabViews.append(button)
			
			self.tabLayout.addArrangedSubview(button)
		}
		
		let paddingView = UIView()
		paddingView.translatesAutoresizingMaskIntoConstraints=false
		paddingView.setContentHuggingPriority(.defaultLow, for: .horizontal)
		self.tabLayout.addArrangedSubview(paddingView)
		
		
		changeTabColor(selected: 0)
		
	}
	
	private func setupView(){
		self.addSubview(tabLayout)
		self.addSubview(tabStripIndicatorBackground)
		self.addSubview(tabStripIndicator)
	}
	private func setupLayout(){
		self.tabLayout.snp.makeConstraints{[unowned self] make in
			make.left.right.top.equalTo(self)
			make.height.equalTo(self.snp.height).offset(-2)
		}
		
		self.tabStripIndicatorBackground.snp.makeConstraints{[unowned self] make in
			make.left.right.bottom.equalTo(self)
			make.height.equalTo(2)
		}
		self.tabStripIndicator.snp.makeConstraints{[unowned self] make in
			make.left.right.bottom.equalTo(self)
			make.height.equalTo(2)
			make.width.equalTo(self).multipliedBy(0.2)
		}
	}
	
	private func makeTabItem(title : String) -> UIButton{
		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints=false
		button.setTitle(title, for: .normal)
		button.addTarget(self, action: #selector(selectTab(_:)), for: .touchUpInside)
		unSelectButton(button: button)
		return button
	}
	
	private func unSelectButton(button : UIButton){
		button.setTitleColor(self.defaultColor, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
	}
	private func selectButton(button : UIButton){
		button.setTitleColor(self.primaryColor, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
	}
}
extension TabLayout{
	
	@objc  func selectTab(_ sender : UIButton){
		if let selectedIdx = tabViews.firstIndex(of: sender){
			selectedTab = selectedIdx
			
		}
	}
	
	private func changeTabColor(selected : Int){
		
		print(#function)
		
		for i in 0..<tabViews.count{
			let button = tabViews[i]
			
			if i == selected{
				selectButton(button: button)
			}else{
				unSelectButton(button: button)
			}
			
		}
	}
	private func moveTabIndicator(selected : Int){
		let button = tabViews[selected]
		
		let originalFrame = self.tabStripIndicator.frame
		
		UIView.animate(withDuration: 0.25){  [unowned self] in
			self.tabStripIndicator.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.0, 1.0)
		}
		UIView.animate(withDuration: 0.25, delay: 0.25, options: [], animations: { [unowned self] in
			self.tabStripIndicator.layer.transform = CATransform3DIdentity
		}, completion: nil)
		
		
		
		UIView.animate(withDuration: 0.5){
			self.tabStripIndicator.frame = CGRect(x: button.frame.origin.x, y: originalFrame.origin.y, width: button.frame.width, height: originalFrame.height)
			
		}
	}
	
}

