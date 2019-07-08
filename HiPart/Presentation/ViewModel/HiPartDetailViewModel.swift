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
			self.delegate?.onChangeProfileDetail(profileDetail: profileDetail)
			self.delegate?.onChangeRefreshState(isRefreshing: isRefreshing)
		}
	}
	
	var isRefreshing : Bool = false{
		didSet{
			delegate?.onChangeRefreshState(isRefreshing: self.isRefreshing)
		}
	}
	
	
	
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
	func onChangeRefreshState(isRefreshing : Bool)
}
