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
	@IBOutlet var idLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var backButton: UIButton!
	
	
    let viewModel = PortfolioViewModel()
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
		self.backButton.imageView?.tintColor = UIColor.white
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
}
