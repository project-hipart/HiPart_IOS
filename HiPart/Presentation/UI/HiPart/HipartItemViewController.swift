
import UIKit
import Hero

class HipartItemViewController: UIViewController {
	private let viewModel = HiPartViewModel()
	@IBOutlet var collectionView: UICollectionView!
}

extension HipartItemViewController{
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupBinding()
		// Do any additional setup after loading the view.
	}
}
extension HipartItemViewController : HiPartViewModelDelegate{
	func onChangeProfiles(profiles: [ProfileDTO]) {
		self.collectionView.reloadData()
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
	private func setupBinding(){
		self.viewModel.delegate = self
	}
}
extension HipartItemViewController : UICollectionViewDelegate, UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.profiles.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell{
			cell.thumbnailView.hero.id = "SearchCollectionViewCellHeroId\(indexPath.item)"
			cell.setProfile(profile: viewModel.profiles[indexPath.row])
			return cell
			
		}
		
		fatalError()
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell{
			
			navigateDetailViewController(cell: cell)
		}
	}
}
extension HipartItemViewController{
	private func navigateDetailViewController(cell : SearchCollectionViewCell){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: String(describing: HipartDetailViewController.self)) as? HipartDetailViewController{
			vc.imageViewHeroId = cell.thumbnailView.hero.id ?? ""
			vc.hero.modalAnimationType = .fade
			self.present(vc, animated: true, completion: nil)
		}
		
		
	}
}

