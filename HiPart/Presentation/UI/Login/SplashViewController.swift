//
//  SplashViewController.swift
//  HiPart
//
//  Created by 최은희 on 09/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit
import Lottie
import Hero

class SplashViewController: UIViewController {

	@IBOutlet var lottieView: AnimationView!
	override func viewDidLoad() {
        super.viewDidLoad()
		playAnimation()
        // Do any additional setup after loading the view.
    }
	func playAnimation(){
		
		if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationViewController"){
			let anim : Animation = Animation.named("data")!
			lottieView.animation = anim
			lottieView.play{[unowned self] finished in
				self.present(vc, animated: true, completion: nil)
			}
		}
		
		
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
