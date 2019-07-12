//
//  MyPagePickViewController.swift
//  HiPart
//
//  Created by 최은희 on 12/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class MyPagePickViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = MyPagePickViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.viewModel.delegate = self
        // Do any additional setup after loading the view.
        
        setupView()
        
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.hero.dismissViewController()
    }

}
extension MyPagePickViewController : MyPagePickViewModelDelegate{
    func onChangeProfiles(profiles: [ProfileDTO]) {
        self.collectionView.reloadData()
    }
    func onChangeRefreshState(isRefreshing: Bool) {
        if isRefreshing{
            LoadingView.showLoadingView()
        }else{
            LoadingView.hideLoadingView()
        }
    }

}

extension MyPagePickViewController {
    private func setupView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width * 0.9, height: 171)
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        self.collectionView.collectionViewLayout = layout


    }
}

extension MyPagePickViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell{
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
            
            self.navigateDetailViewController(myProfile: false, type: item.type, nickname: item.nickname, imageViewHeroId: cell.thumbnailView.hero.id ?? "",profileImage: cell.thumbnailView.image,pickState: item.pickState,pickCount : item.pickCount)
            
        }
    }
}

extension MyPagePickViewController : SearchCollectionViewCellDelegate{
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
