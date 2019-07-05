
import UIKit

class MasterViewController: UITabBarController {
	
	let viewModel = MasterViewModel()
	private lazy var tapGestureRecognizer : UITapGestureRecognizer = {
		let tap = UITapGestureRecognizer()
		tap.addTarget(self, action: #selector(tapBackground(_:)))
		return tap
	}()
	private var portfolioBottomSheetVC : PortfolioBottomSheetViewController? = nil
	
}

extension MasterViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.delegate = self
		self.setupView()
	}
	
}
//MARK: Setup
extension MasterViewController{
	private func setupView(){
		Device.tabBarHeight = self.tabBar.frame.height
		self.delegate = self
	}
}

//MARK: TabBar
extension MasterViewController {
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		if let index = tabBar.items?.firstIndex(of: item){
			viewModel.tabBarIndex = index
		}
	}
}

extension MasterViewController : UITabBarControllerDelegate{
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		
		if viewController is PortfolioEditViewController{
			showPortfolioBottomViewController()

			adjustTabBarItemImages(isPortfolioOpen: true)
			
			return false
		}
	
		
		return true
	}
	func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
		print(#function)
	}
	
	func adjustTabBarItemImages(isPortfolioOpen : Bool){
		if !isPortfolioOpen{
			self.tabBar.items?[2].image = UIImage(named : "mainTbPofolOffIcon")
			self.tabBar.tintColor = UIColor.mainPurple
			
			self.tabBar.items?[0].selectedImage = UIImage(named : "mainTbHomeOnIcon")
			self.tabBar.items?[1].selectedImage = UIImage(named : "mainTbHipotOnIcon")
			self.tabBar.items?[3].selectedImage = UIImage(named : "mainTbMyPageOnIcon")
		}else{
			self.tabBar.tintColor = UIColor.init(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0)
			self.tabBar.items?[2].image = UIImage(named : "mainTbPofolOnIcon")?.withRenderingMode(.alwaysOriginal)
			
			self.tabBar.items?[0].selectedImage = UIImage(named : "mainTbHomeOffIcon")?.withRenderingMode(.alwaysOriginal)
			self.tabBar.items?[1].selectedImage = UIImage(named : "mainTbHipotOffIcon")?.withRenderingMode(.alwaysOriginal)
			self.tabBar.items?[3].selectedImage = UIImage(named : "mainTbMyPageOffIcon")?.withRenderingMode(.alwaysOriginal)
		}
	}
}
//NAVIGATE
extension MasterViewController{
	private func showPortfolioBottomViewController(){
		let blurView = self.view.addBlurArea(area: self.view.bounds, style: .dark)
		portfolioBottomSheetVC = PortfolioBottomSheetViewController.loadFromNib()
		self.add(asChildViewController: portfolioBottomSheetVC!, to: self.view)
		
		portfolioBottomSheetVC?.view.isUserInteractionEnabled = true
		portfolioBottomSheetVC?.view.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc private func tapBackground(_ sender : UITapGestureRecognizer){
		print(#function)
		adjustTabBarItemImages(isPortfolioOpen: false)
		if let vc = self.portfolioBottomSheetVC{
			self.remove(asChildViewController: vc)
			self.view.removeBlurView()
			self.view.removeGestureRecognizer(tapGestureRecognizer)
		}
	}
}

extension MasterViewController: MasterViewModelDelegate {
	func onTabChanged(num: Int) {
		print(#function)
		//        self.setSelectedItem(index: num)
	}
}


extension UIViewController {
	static func loadFromNib() -> Self {
		func instantiateFromNib<T: UIViewController>() -> T {
			return T.init(nibName: String(describing: T.self), bundle: nil)
		}
		
		return instantiateFromNib()
		
	}
}

extension String {
	func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		for string in strings {
			let range = (self as NSString).range(of: string)
			attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
		}
		
		guard let characterSpacing = characterSpacing else {return attributedString}
		
		attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
		
		return attributedString
	}
}
