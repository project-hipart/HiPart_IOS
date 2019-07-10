
import UIKit
<<<<<<< HEAD
import Hero
=======
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a

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
<<<<<<< HEAD
		
//        self.hero.isEnabled = true
//        self.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))
        
=======
		TokenHelper.saveAccessToken(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuaWNrbmFtZSI6ImN1dGV5YW5nIiwiaWR4IjozLCJ0eXBlIjoxLCJpYXQiOjE1NjI1NjcyNTgsImV4cCI6MTU2Mzc3Njg1OCwiaXNzIjoiaWcifQ.WHzr5l6RfzF3Uw88qUeuJe9rpLD4RHlsCB9pto-4MbM")
		
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
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
		
<<<<<<< HEAD
		if viewController is PortfolioEditViewController{
=======
		if viewController is PortfolioViewController{
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			showPortfolioBottomViewController()

			
			return false
		}
	
		
		return true
	}
<<<<<<< HEAD
=======
	
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
		print(#function)
		
	}
	
}
//NAVIGATE
extension MasterViewController{
	private func showPortfolioBottomViewController(){
		portfolioBottomSheetVC = PortfolioBottomSheetViewController.loadFromNib()
		self.add(asChildViewController: portfolioBottomSheetVC!, to: self.view)
		
		portfolioBottomSheetVC?.view.isUserInteractionEnabled = true
		portfolioBottomSheetVC?.view.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc private func tapBackground(_ sender : UITapGestureRecognizer){
		if let vc = self.portfolioBottomSheetVC{
			self.remove(asChildViewController: vc)
<<<<<<< HEAD
			self.view.removeBlurView()
=======
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
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
