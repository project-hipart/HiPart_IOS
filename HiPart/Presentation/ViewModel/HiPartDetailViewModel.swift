//
//  HiPartViewModel.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class HiPartDetailViewModel {
	private let disposeBag = DisposeBag()
	
	weak var delegate : HiPartDetailViewModelDelegate? = nil{
		didSet{
			self.delegate?.onChangeRefreshState(isRefreshing: isRefreshing)
		}
	}
	
	var isRefreshing : Bool = false{
		didSet{
			delegate?.onChangeRefreshState(isRefreshing: self.isRefreshing)
		}
	}
	
	
	
	
}
protocol HiPartDetailViewModelDelegate : NSObjectProtocol{
	func onChangeRefreshState(isRefreshing : Bool)
}
