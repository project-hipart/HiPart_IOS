
import UIKit
import Hero

class HipartItemViewController: UIViewController {

	@IBOutlet var collectionView: UICollectionView!
}

extension HipartItemViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		// Do any additional setup after loading the view.
	}
}
extension HipartItemViewController{
	private func setupView(){
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.itemSize = CGSize(width: self.view.frame.width * 0.9, height: 171)
		
		let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
		
		layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		self.collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
		self.collectionView.collectionViewLayout = layout
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
	}
}
extension HipartItemViewController : UICollectionViewDelegate, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell{
			return cell
			
		}
		fatalError()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		navigateDetailViewController()
	}
	
}
extension HipartItemViewController{
	private func navigateDetailViewController(){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: HipartDetailViewController.self))
		
		vc.hero.modalAnimationType = .selectBy(presenting: .cover(direction: .left), dismissing: .uncover(direction: .right))
		self.present(vc, animated: true, completion: nil)
	}
}
