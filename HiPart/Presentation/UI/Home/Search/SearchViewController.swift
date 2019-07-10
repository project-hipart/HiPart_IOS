import UIKit
import Hero

class SearchViewController: UIViewController {
<<<<<<< HEAD
=======
	private var viewModel = SearchViewModel()
	
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	@IBOutlet var backButton: UIButton!
	@IBOutlet var searchTextField: SearchTextField!
	@IBOutlet var recentlyCollectionView: UICollectionView!
	@IBOutlet var collectionViewBottomConstraint: NSLayoutConstraint!
	
<<<<<<< HEAD
	
=======
	private var recentlySearchKeywords : [String] = RecentlySearchRepository.shared.getRecentlySearchKeyword()
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
}

//MARK: Lifecycle
extension SearchViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))
<<<<<<< HEAD
=======
		//		self.navigationController?.hero.navigationAnimationType =
		
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		
		addKeyboardNotifications()
		setupView()
		setupBinding()
		
		
	}
<<<<<<< HEAD
=======
	override func viewWillAppear(_ animated: Bool) {
		recentlySearchKeywords = RecentlySearchRepository.shared.getRecentlySearchKeyword()
		self.recentlyCollectionView.reloadData()
	}
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
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
<<<<<<< HEAD
		navigateDetailViewController()
=======
		self.checkKeywordAndNavigate()
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
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
<<<<<<< HEAD
		self.searchTextField.resignFirstResponder()

		navigateDetailViewController()
=======
		
		self.checkKeywordAndNavigate()
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		
		
		return true
	}
}
<<<<<<< HEAD
//MARK: CollectionView
extension SearchViewController : UICollectionViewDelegate{
	
=======

//MARK: CollectionViewCell Delegate
extension SearchViewController : RecentlyCollectionViewCellDelegate{
	func onTapXButton(title: String, idx : Int) {
		debugE(title)
		self.recentlySearchKeywords.remove(at: idx)
		RecentlySearchRepository.shared.saveRecentlySearchKeyword(keywords: self.recentlySearchKeywords)
		self.recentlyCollectionView.reloadData()
	}
}
//MARK: CollectionView
extension SearchViewController : UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? RecentlyCollectionViewCell{
			let keyword = cell.title
			self.searchTextField.text = keyword
			self.checkKeywordAndNavigate(needAddRecentlyKeyword : false)
		}
	}
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
}
//MARK: CollectionView Data Source
extension SearchViewController : UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyCollectionViewCell", for: indexPath) as? RecentlyCollectionViewCell{
<<<<<<< HEAD
			
			
			cell.title = "최근 검색어"
=======
			cell.delegate = self
			cell.idx = indexPath.row
			cell.title = recentlySearchKeywords[indexPath.row]
			cell.startAnim()
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			
			return cell
		}else{
			fatalError("no cell")
		}
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
<<<<<<< HEAD
		return 20
=======
		return recentlySearchKeywords.count
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	}
}

//MARK: Actions
extension SearchViewController{
	
<<<<<<< HEAD
	@IBAction func tapSearchButton(_ sender: Any) {
		navigateDetailViewController()
=======
	func checkKeywordAndNavigate(needAddRecentlyKeyword : Bool = true) {
		if let keyword = self.searchTextField.text{
			if keyword.count > 0{
				navigateDetailViewController(needAddRecentlyKeyword: needAddRecentlyKeyword)
			}
		}
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		
	}
	
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
}

//MARK: Navigations
extension SearchViewController{
<<<<<<< HEAD
	private func navigateDetailViewController(){
		
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailViewController"){
=======
	private func navigateDetailViewController(needAddRecentlyKeyword : Bool = true){
		self.searchTextField.resignFirstResponder()
		
		let id = String(describing: SearchDetailViewController.self)
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: id) as? SearchDetailViewController{
			let keyword = self.searchTextField.text!
			vc.keyword = keyword
			if needAddRecentlyKeyword{
				RecentlySearchRepository.shared.saveRecentlySearchKeyword(keyword:keyword)
			}
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}
