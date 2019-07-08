import UIKit
import Hero

class SearchViewController: UIViewController {
	@IBOutlet var backButton: UIButton!
	@IBOutlet var searchTextField: SearchTextField!
	@IBOutlet var recentlyCollectionView: UICollectionView!
	@IBOutlet var collectionViewBottomConstraint: NSLayoutConstraint!
	
	
}

//MARK: Lifecycle
extension SearchViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))
		
		addKeyboardNotifications()
		setupView()
		setupBinding()
		
		
	}
}

//MARK: Setup
extension SearchViewController{
	private func setupView(){
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 0
		layout.itemSize = CGSize(width: Device.screenWidth * 0.85, height: 30)
		self.recentlyCollectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		
		self.recentlyCollectionView.collectionViewLayout = layout
		
		self.searchTextField.searchDelegate = self
	}
	private func setupBinding(){
		
	}
}
extension SearchViewController : SearchTextFieldDelegate{
	func tapSearchButton() {
		navigateDetailViewController()
	}
}

//MARK: Keyboard
extension SearchViewController{
	func addKeyboardNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow(notification:)),
											   name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide(notification:)),
											   name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
			
			UIView.animate(withDuration: duration){[unowned self] in
				self.collectionViewBottomConstraint.constant = -(20 + keyboardSize.height)
				self.view.layoutIfNeeded()
			}
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
		UIView.animate(withDuration: duration) {
			self.collectionViewBottomConstraint.constant = -(20)
			self.view.setNeedsLayout()
		}
	}
}
extension SearchViewController : UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.searchTextField.resignFirstResponder()

		navigateDetailViewController()
		
		
		return true
	}
}
//MARK: CollectionView
extension SearchViewController : UICollectionViewDelegate{
	
}
//MARK: CollectionView Data Source
extension SearchViewController : UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyCollectionViewCell", for: indexPath) as? RecentlyCollectionViewCell{
			
			
			cell.title = "최근 검색어"
			
			return cell
		}else{
			fatalError("no cell")
		}
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}
}

//MARK: Actions
extension SearchViewController{
	
	@IBAction func tapSearchButton(_ sender: Any) {
		navigateDetailViewController()
		
	}
	
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
}

//MARK: Navigations
extension SearchViewController{
	private func navigateDetailViewController(){
		
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailViewController"){
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}
