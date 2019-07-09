
import UIKit
import Hero

class HipartItemViewController: UIViewController {
	let viewModel = HiPartViewModel()
	
	@IBOutlet var collectionView: UICollectionView!
	
	private lazy var refreshControl : UIRefreshControl = {
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(refresh), for: .valueChanged)
		
		return control
	}()
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
	
	@objc private func refresh(){
		viewModel.loadDatas(viewModel.currentTab)
	}
	
	func onChangeProfiles(profiles: [ProfileDTO]) {
		self.collectionView.reloadData()
	}
	func onChangeRefreshState(isRefreshing: Bool) {
		if isRefreshing{
			self.refreshControl.beginRefreshing()
		}else{
			self.refreshControl.endRefreshing()
		}
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
		
		
		self.collectionView.refreshControl = refreshControl
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
			cell.startAnim()
			cell.thumbnailView.hero.id = "SearchCollectionViewCellHeroId\(indexPath.item)"
			cell.setProfile(profile: viewModel.profiles[indexPath.row])
			cell.delegate = self
			return cell
			
		}
		
		fatalError()
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell{
			
			let item = viewModel.profiles[indexPath.row]
			navigateDetailViewController(cell: cell,profile: item)
		}
	}
}
extension HipartItemViewController : SearchCollectionViewCellDelegate{
	func onChangePickState(profile : ProfileDTO,picked: Bool) {
		
		if let idx = self.viewModel.profiles.firstIndex(where : {p in p.nickname == profile.nickname}){
			let profile = self.viewModel.profiles[idx]
			profile.pickState = PickState.getPickedStateWithBool(picked)
			if picked{
				profile.pickCount += 1
			}else{
				profile.pickCount -= 1
			}
		}
	}
}

extension HipartItemViewController{
	private func navigateDetailViewController(cell : SearchCollectionViewCell,profile : ProfileDTO){
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		if let vc = sb.instantiateViewController(withIdentifier: String(describing: HipartDetailViewController.self)) as? HipartDetailViewController{
			vc.imageViewHeroId = cell.thumbnailView.hero.id ?? ""
			vc.hero.modalAnimationType = .fade
			vc.profile = profile
			vc.profileImage = cell.thumbnailView.image
			self.present(vc, animated: true, completion: nil)
		}
	}
}

