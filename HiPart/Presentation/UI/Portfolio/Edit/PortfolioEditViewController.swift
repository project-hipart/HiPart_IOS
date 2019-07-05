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
	
	
    let viewModel = PortfolioViewModel()
	
	private lazy var uploadViewController: PortfolioEditViewController = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Portfolio", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "PortfolioUploadViewController") as! PortfolioEditViewController
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController, to: self.uploadContainerView)
		
		return viewController
	}()
	
	
}

extension PortfolioEditViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.setupView()
        viewModel.delegate = self
		self.setFilters([Filter.sample,Filter.sample])
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
//		addChip.addTarget(self, action: #selector(tapUpdateFilter), for: .touchUpInside)
		
		
		let paddingView = UIView()
		paddingView.translatesAutoresizingMaskIntoConstraints=false
		paddingView.setContentHuggingPriority(.defaultLow, for: .horizontal)
		
		
		self.filterStackView.addArrangedSubview(addChip)
		self.filterStackView.addArrangedSubview(paddingView)
		
		
	}
}

//MARK: ViewModelDelegate
extension PortfolioEditViewController : PortfolioViewModelDelegate {
    func onTextChanged(text: String) {
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
	
	@objc private func tapUpdateFilter(){
		
	}
}
