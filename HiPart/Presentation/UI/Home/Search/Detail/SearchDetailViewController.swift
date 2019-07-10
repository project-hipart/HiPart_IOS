
import UIKit
import Hero

class SearchDetailViewController: UIViewController {
	var keyword : String = ""
	private var viewModel = SearchDetailViewModel()
	
	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var notFoundImageView: UIImageView!
	@IBOutlet var notFoundBigLabel: UILabel!
	@IBOutlet var notFoundSmallLabel: UILabel!
	@IBOutlet var notFoundView: UIView!
	@IBOutlet var tabLayout: TabLayout!
	@IBOutlet var searchTextField: SearchTextField!
	
}

//MARK: Lifecycle
extension SearchDetailViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		debugE(#function)
		setupView()
		setupBinding()
		
		viewModel.loadDatas(keyword: keyword)
	}
}

//MARK: ViewModel Delegate
extension SearchDetailViewController : SearchDetailViewModelDelegate{
	func onChangeProfiles(profiles: [ProfileDTO]) {
		self.collectionView.reloadData()
	}
}

//MARK: Setup
extension SearchDetailViewController{
	
	private func setupBinding(){
		self.viewModel.delegate = self
	}
	
	private func setupView(){
		
		collectionView.register(
			UINib(nibName: "SearchCollectionViewCell", bundle: nil),
			forCellWithReuseIdentifier: String(describing: SearchCollectionViewCell.self)
		)
		
		let layout = UICollectionViewFlowLayout()
		
		layout.sectionInset = UIEdgeInsets( top : 10 , left : 10 , bottom : 10 , right : 10)
		layout.minimumLineSpacing = 20
		layout.minimumInteritemSpacing = 0
		layout.itemSize = CGSize(width: 325.adjustedWidth , height : 171 )
		
		collectionView.collectionViewLayout = layout
		
		self.notFoundSmallLabel.setLineHeight(lineHeight: 1.8)
		self.tabLayout.delegate = self
		self.searchTextField.text = keyword
		
	}
	
}
extension SearchDetailViewController : TabLayoutDelegate{
	func onSelectedTab(_ index: Int) {
		
	

		viewModel.changeTypeFilter(UserType(rawValue: index)!)
	}
}


//MARK: CollectionView
extension SearchDetailViewController : UICollectionViewDelegate{
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		let offsetY = scrollView.contentOffset.y
		
		
		if offsetY < 0{
			//			adjustHeaderViewCollapsingProgress(progress: 0)
		}else{
			if offsetY < 250{
				//				adjustHeaderViewCollapsingProgress(progress: min(1.0, offsetY/200))
			}
		}
		
	}
}
//MARK: DataSource
extension SearchDetailViewController : UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.profiles.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let profile = viewModel.profiles[indexPath.row]
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionViewCell.self) , for: indexPath) as? SearchCollectionViewCell{
			cell.setProfile(profile: profile)
			cell.thumbnailView.hero.id = "HEROHERO\(indexPath.row)"
			
			return cell
		}else{
			fatalError()
		}
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let item = viewModel.profiles[indexPath.row]
		
		if let cell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell{
			self.navigateDetailViewController(myProfile: false, type: item.type, nickname: item.nickname, imageViewHeroId: cell.thumbnailView.hero.id ?? "", profileImage: cell.thumbnailView.image)
		}
		
		
		
	}
}
//MARK: Action
extension SearchDetailViewController{
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@IBAction func screenEdgePanGestureRecognizer(_ sender: UIScreenEdgePanGestureRecognizer) {
		let x = sender.translation(in: self.view).x
		let screenWidth = UIScreen.main.bounds.width
		
		switch sender.state{
		case .began:
			self.hero.dismissViewController()
		case .changed:
			Hero.shared.update(x/screenWidth)
		case .cancelled:
			Hero.shared.cancel()
		case .ended:
			if x > screenWidth * 0.5{
				Hero.shared.finish(animate: true)
			}else{
				Hero.shared.cancel(animate: true)
			}
			
			
		default:
			break
		}
	}
}
