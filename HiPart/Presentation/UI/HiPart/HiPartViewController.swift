//
//  HiPartViewController.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class HiPartViewController: UIViewController {

	@IBOutlet var adViewContainer: UIView!
	@IBOutlet var itemViewController : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.setupView()
        // Do any additional setup after loading the view.
    }
	
	private func setupView(){
	}
	
}

extension HiPartViewController{
	@IBAction func tapEditFilter(_ sender: Any) {
		let sb = UIStoryboard(name: "Portfolio", bundle: nil)
		let vc = sb.instantiateViewController(withIdentifier: String(describing: PortfolioFilterEditViewController.self))
		
		self.add(asChildViewController: vc, to: self.view)
	}
}
