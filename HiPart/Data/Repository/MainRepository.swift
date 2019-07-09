//
//  MainRepository.swift
//  HiPart
//
//  Created by 최은희 on 09/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation
import RxSwift


class MainRepository{
	static let shared = MainRepository()
	private init(){}
	
	func search(keyword : String) -> Single<Array<ProfileDTO>>{
		return MainAPI.requestSearch(keyword: keyword).map{json in
			var result : [ProfileDTO] = []
			let datas = json["data"].arrayValue
			
			for data in datas{
				let profile = ProfileDTO.init(fromJSON: data)
				result.append(profile)
			}
			
			return result
		}
	}
	
	func notification() -> Single<Array<Notification>>{
		return MainAPI.requestNotification().map{json in
			
			var result : [Notification] = []
			
			for data in json["data"].arrayValue{
				
				let notification = Notification.init(fromJson: data)
				
				result.append(notification)
				
				
			}
			
			return result
			
		}
	}
}
