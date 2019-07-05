
import UIKit
import Hero

class PortfolioBottomSheetViewController: UIViewController {
	
	@IBOutlet var bottomSheet: UIView!
	@IBOutlet var backgroundView: UIView!
	@IBOutlet var portfolioTap: UITapGestureRecognizer!
	@IBOutlet var todayUploadTap: UITapGestureRecognizer!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		slideUp()
        // Do any additional setup after loading the view.
		addBackgroundTapGestureRecognizer()
    }
	

	
}

//MARK: Setup
extension PortfolioBottomSheetViewController : UIGestureRecognizerDelegate{
	private func slideUp(){
		bottomSheet.transform = CGAffineTransform(translationX: 0, y: Device.tabBarHeight)
		
		UIView.animate(withDuration: 0.3){[unowned self] in
			self.bottomSheet.transform = CGAffineTransform(translationX: 0, y: -Device.tabBarHeight - Device.bottomSafeAreaPadding)
		}
	}
	
	private func addBackgroundTapGestureRecognizer(){
		self.view.isUserInteractionEnabled = true
		
	}
	
	
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		if gestureRecognizer == portfolioTap || gestureRecognizer == todayUploadTap{
			return false
		}
		return true
	}
}

//MARK: Actions
extension PortfolioBottomSheetViewController{
	@IBAction func tapPortfolio(_ sender: Any) {
		if let vc = UIStoryboard(name: "Portfolio", bundle: nil).instantiateInitialViewController(){
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	
	@IBAction func tapTodayUpload(_ sender: Any) {
		
		
		
		if false{
			let vc = UIStoryboard(name: "PortfolioEdit", bundle: nil).instantiateViewController(withIdentifier: String(describing: PortfolioUploadViewController.self))
				self.present(vc, animated: true, completion: nil)
			
		}else{
			let vc = UIStoryboard(name: "PortfolioEdit", bundle: nil).instantiateViewController(withIdentifier: String(describing: PortfolioUploadTranslationViewController.self))
				self.present(vc, animated: true, completion: nil)
			
		}
		
		
	}
	@IBAction func tapBackground(_ sender: Any) {
			if let parent = self.parent{
				parent.remove(asChildViewController: self)
				parent.view.removeBlurView()
			}
	}
	
}
