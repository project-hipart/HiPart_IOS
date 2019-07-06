//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class HipartDetailViewController: UIViewController {
	
	
	
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var uploadContainerView: UIView!
	@IBOutlet var idLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var backButton: UIButton!
	@IBOutlet var filterStackView: UIStackView!
	private var filterViews : [FilterChip] = []
	
//
	
	
}

extension HipartDetailViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.hero.isEnabled=true
		
		self.setupView()
		self.setFilters([Filter.ASMR])
	}
	
}
extension HipartDetailViewController{
	private func setupView(){
		self.backButton.tintColor = UIColor.white
		self.imageView.cornerRadius = 75/2
		
		
	}
	private func setFilters(_ filters : [Filter]){
		//Remove all filterViews in StackView
		for v in filterViews{
			self.filterStackView.removeArrangedSubview(v)
			v.removeFromSuperview()
		}
		
		for filter in filters{
			let view = FilterChip()
			view.translatesAutoresizingMaskIntoConstraints=false
			view.chipSelected = filters[0] == filter
			
			view.setChipTitle(filter.rawValue)
			view.setNeedsLayout()
			
			self.filterStackView.addArrangedSubview(view)
		}
		
		self.filterStackView.addPaddingView()
		
	}
}

//MARK: Actions
extension HipartDetailViewController{
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@objc private func tapEditFilter(){
		
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PortfolioFilterEditViewController.self)){
			self.add(asChildViewController: vc, to: self.view)
		}
	}
	@IBAction func tapContactButton(_ sender: Any) {
		
		let sb = UIStoryboard(name: "HiPart", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PaymentDialogViewController.self))
		
		self.add(asChildViewController: vc, to: self.view)
//		self.present(vc, animated: false, completion: nil)
	}
}