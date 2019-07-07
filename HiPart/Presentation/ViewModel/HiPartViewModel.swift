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

class HiPartViewModel {
	weak var delegate : HiPartViewModelDelegate? = nil{
		didSet{
			self.delegate?.onChangeProfiles(profiles: profiles)
		}
	}
	
	var profiles : [ProfileDTO] = []{
		didSet{
			delegate?.onChangeProfiles(profiles: profiles)
		}
	}
	
	init() {
		loadDatas()
	}
	
	private func loadDatas(){
		AuthAPI.requestSignIn(email: "이메일", password: "패스워드")
			.subscribe(onSuccess: { json in
				let token = json["data"]["tokens"]["token"].stringValue
				TokenHelper.saveAccessToken(token: token)
			}, onError: { err in
				
			})
		
		ProfileRepository.shared.list(flag: .All)
			.subscribe(onSuccess: { profiles in
			self.profiles = profiles
			}, onError: {
				debugE($0)
		})
	}
	
}
protocol HiPartViewModelDelegate : NSObjectProtocol{
	func onChangeProfiles(profiles : [ProfileDTO])
}
