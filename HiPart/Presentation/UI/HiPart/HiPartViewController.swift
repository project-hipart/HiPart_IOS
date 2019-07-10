//
//  HiPartViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HiPartViewController: UIViewController {

<<<<<<< HEAD
	private var itemViewController : HipartItemViewController!
=======
	var itemViewController : HipartItemViewController!
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	
	@IBOutlet var adViewContainer: UIView!
	@IBOutlet var tabLayout: TabLayout!
	
<<<<<<< HEAD
	

    override func viewDidLoad() {
        super.viewDidLoad()

		self.setupView()
        // Do any additional setup after loading the view.
=======
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupView()
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
    }
	
	private func setupView(){
		self.tabLayout.delegate = self
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		debugE(segue.destination)
		
		if segue.destination is HipartItemViewController{
<<<<<<< HEAD
			itemViewController = segue.destination as! HipartItemViewController
=======
			itemViewController = segue.destination as? HipartItemViewController
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		}
	}
}

extension HiPartViewController : TabLayoutDelegate{
	func onSelectedTab(_ index: Int) {
		
		itemViewController.viewModel.loadDatas(ProfileFlag(rawValue: index) ?? ProfileFlag.All)
	}
}

<<<<<<< HEAD
extension HiPartViewController{
	@IBAction func tapEditFilter(_ sender: Any) {
		let sb = UIStoryboard(name: "Portfolio", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PortfolioFilterEditViewController.self))
		
		self.add(asChildViewController: vc, to: self.view)
=======
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
		
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	}
}
