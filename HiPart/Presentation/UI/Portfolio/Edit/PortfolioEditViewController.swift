//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class PortfolioEditViewController: UIViewController {

	
	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var uploadContainerView: UIView!
	@IBOutlet var idLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var backButton: UIButton!
	@IBOutlet var filterStackView: UIStackView!
	private var filterViews : [FilterChip] = []
	
	
	
}

extension PortfolioEditViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.setupView()
		self.setFilters([Filter.ASMR])
    }

}
extension PortfolioEditViewController{
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
		
		let addChip = FilterChip()
		addChip.translatesAutoresizingMaskIntoConstraints=false
		addChip.borderColor = UIColor.lightGrey
		addChip.setChipTitle("필터 수정하기")
		addChip.setNeedsLayout()
		addChip.addTarget{[unowned self] in
			self.tapEditFilter()
		}
		
	
		self.filterStackView.addArrangedSubview(addChip)
		self.filterStackView.addPaddingView()
		
	}
}

//MARK: Actions
extension PortfolioEditViewController{
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@IBAction func cancelButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	
	@objc private func tapEditFilter(){
		
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PortfolioFilterEditViewController.self)){
			self.add(asChildViewController: vc, to: self.view)
		}
	}
}
