//
//  HiPartViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HiPartViewController: UIViewController {

	var itemViewController : HipartItemViewController!
	
	@IBOutlet var adViewContainer: UIView!
	@IBOutlet var tabLayout: TabLayout!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupView()
    }
	
	private func setupView(){
		self.tabLayout.delegate = self
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		debugE(segue.destination)
		
		if segue.destination is HipartItemViewController{
			itemViewController = segue.destination as? HipartItemViewController
		}
	}
}

extension HiPartViewController : TabLayoutDelegate{
	func onSelectedTab(_ index: Int) {
		
		itemViewController.viewModel.loadDatas(ProfileFlag(rawValue: index) ?? ProfileFlag.All)
	}
}

extension HiPartViewController : FilterChangeDelegate{
	func filterChanged(filter: Filter?) {
		itemViewController.setFilter(filter: filter)
	}
}

extension HiPartViewController{
	@IBAction func tapEditFilter(_ sender: Any) {
		let sb = UIStoryboard(name: "Common", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PortfolioFilterEditViewController.self)) as! PortfolioFilterEditViewController
		vc.delegate = self
		vc.hidesBottomBarWhenPushed = true
		vc.selectedFilter = self.itemViewController.viewModel.currentFilter
		self.navigationController?.pushViewController(vc, animated: true)
		
	}
}
