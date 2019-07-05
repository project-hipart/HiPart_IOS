
import UIKit
import Hero

class SearchDetailViewController: UIViewController {

	@IBOutlet var collectionView: UICollectionView!
	
	private let sampleDatas = [
		"123"
	
	]

}

//MARK: Lifecycle
extension SearchDetailViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
	}
}

//MARK: Setup
extension SearchDetailViewController{
	
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
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionViewCell.self) , for: indexPath) as? SearchCollectionViewCell{
			
			
			return cell
		}else{
			fatalError()
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
		
		print(1)
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
