
import UIKit
import Hero

class SearchDetailViewController: UIViewController {
	
	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var notFoundImageView: UIImageView!
	@IBOutlet var notFoundBigLabel: UILabel!
	@IBOutlet var notFoundSmallLabel: UILabel!
	@IBOutlet var notFoundView: UIView!
	@IBOutlet var tabLayout: TabLayout!
	
	private var sampleDatas  : [String] = ["123"]
	
}

//MARK: Lifecycle
extension SearchDetailViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		setupView()
	}
}
extension UILabel {
	


	func setLineHeight(lineHeight: CGFloat) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 1.0
		paragraphStyle.lineHeightMultiple = lineHeight
		paragraphStyle.alignment = self.textAlignment
		
		let attrString = NSMutableAttributedString()
		if (self.attributedText != nil) {
			attrString.append( self.attributedText!)
		} else {
			attrString.append( NSMutableAttributedString(string: self.text!))
			attrString.addAttribute(NSAttributedString.Key.font, value: self.font, range: NSMakeRange(0, attrString.length))
		}
		attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
		self.attributedText = attrString
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
		
		self.notFoundSmallLabel.setLineHeight(lineHeight: 1.8)
		self.tabLayout.delegate = self
	}
	
}
extension SearchDetailViewController : TabLayoutDelegate{
	func onSelectedTab(_ index: Int) {
		
		if index == 1{
			UIView.animate(withDuration: 0.3){[unowned self] in
				self.notFoundView.isHidden = false
			}
		}else{
			UIView.animate(withDuration: 0.3){[unowned self] in
				self.notFoundView.isHidden = true
			}
		}
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
