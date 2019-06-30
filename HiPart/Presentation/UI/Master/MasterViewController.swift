//
//  ViewController.swift
//  HiPart
//
//  Created by 최은희 on 29/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import UIKit

class MasterViewController: UITabBarController {
    
    let viewModel = MasterViewModel()
}

extension MasterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
//        self.tabBar.delegate = self
    }
    
}

extension MasterViewController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item){
            viewModel.tabBarIndex = index
        }
    }
}

extension MasterViewController: MasterViewModelDelegate {
    func onTabChanged(num: Int) {
        print(#function)
        self.setSelectedItem(index: num)
    }
}
