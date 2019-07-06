
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
		
		self.testData()
	}
	
}
//MARK: Setup
extension MasterViewController{
	private func setupView(){
		Device.tabBarHeight = self.tabBar.frame.height
		self.delegate = self
	}
	
	private func testData(){
//		AuthAPI.requestSignIn(email: "jig1@naver.com", password: "123")
//			.subscribe(onSuccess: {
//				debugE("success",$0)
//				let token = $0["data"]["token"]
//				debugE(token)
//			}, onError: {
//				debugE("error", $0)
//				})
		AuthAPI.requestDuplicateCheck(flag: .email, input: "jig1@naver.com")
			.subscribe(onSuccess: {
//				debugE($0)
				if $0["data"].intValue == DuplicateCheckResult.duplicate.rawValue{
					debugE("중복")
				}else{
					debugE("중복 X")
				}
			}, onError: {
				
				debugE($0)
				})
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

			
			return false
		}
	
		
		return true
	}
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
