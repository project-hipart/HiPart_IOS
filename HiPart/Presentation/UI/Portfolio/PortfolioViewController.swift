//
//  PortfolioViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    let viewModel = PortfolioViewModel()
}

extension PortfolioViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }

}

//MARK: ViewModelDelegate
extension PortfolioViewController : PortfolioViewModelDelegate {
    func onTextChanged(text: String) {
    }
}
