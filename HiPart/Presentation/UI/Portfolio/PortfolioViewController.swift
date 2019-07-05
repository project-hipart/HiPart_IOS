//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Hero

class PortfolioViewController: UIViewController {

	@IBOutlet var typeLabel: UILabel!
	@IBOutlet var uploadContainerView: UIView!
	@IBOutlet var idLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var backButton: UIButton!
	@IBOutlet var filterStackView: UIStackView!
	
	
    let viewModel = PortfolioViewModel()
	
	private lazy var uploadViewController: PortfolioUploadViewController = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Portfolio", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "PortfolioUploadViewController") as! PortfolioUploadViewController
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController, to: self.uploadContainerView)
		
		return viewController
	}()
	
	
}

extension PortfolioViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.setupView()
        viewModel.delegate = self
    }

}
extension PortfolioViewController{
	private func setupView(){
		self.backButton.tintColor = UIColor.white
		self.imageView.cornerRadius = 75/2
		
	}
}

//MARK: ViewModelDelegate
extension PortfolioViewController : PortfolioViewModelDelegate {
    func onTextChanged(text: String) {
    }
}
//MARK: Actions
extension PortfolioViewController{
	@IBAction func tapBackButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
	@IBAction func cancelButton(_ sender: Any) {
		self.hero.dismissViewController()
	}
}
