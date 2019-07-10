//
//  HiPartViewModel.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation
<<<<<<< HEAD
import RxSwift
=======

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
import Alamofire
import SwiftyJSON

class HiPartDetailViewModel {
<<<<<<< HEAD
	private let disposeBag = DisposeBag()
	
	weak var delegate : HiPartDetailViewModelDelegate? = nil{
		didSet{
			self.delegate?.onChangeProfileDetail(profileDetail: profileDetail)
=======
	
	weak var delegate : HiPartDetailViewModelDelegate? = nil{
		didSet{
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			self.delegate?.onChangeRefreshState(isRefreshing: isRefreshing)
		}
	}
	
	var isRefreshing : Bool = false{
		didSet{
			delegate?.onChangeRefreshState(isRefreshing: self.isRefreshing)
		}
	}
	
	
	
<<<<<<< HEAD
	var profileDetail : ProfileDetailDTO? = nil{
		didSet{
			delegate?.onChangeProfileDetail(profileDetail: self.profileDetail!)
		}
	}
	
	
	func loadData(profile : ProfileDTO){
		ProfileRepository.shared.detail(nickname: profile.nickname)
			.subscribe(onSuccess: {profileDetail in
				self.profileDetail = profileDetail
			}, onError: {err in
				debugE(err)
			}).disposed(by: disposeBag)
	}
	
	
}
protocol HiPartDetailViewModelDelegate : NSObjectProtocol{
	func onChangeProfileDetail(profileDetail : ProfileDetailDTO?)
=======
	
}
protocol HiPartDetailViewModelDelegate : NSObjectProtocol{
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	func onChangeRefreshState(isRefreshing : Bool)
}
