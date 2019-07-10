//
//  MainRepository.swift
//  HiPart
//
//  Created by 최은희 on 09/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation



class MainRepository{
	static let shared = MainRepository()
	private init(){}
	
	func search(keyword : String,completion : @escaping (Array<ProfileDTO>?) -> Void){
		
		MainAPI.requestSearch(keyword: keyword){json in
			
			if let json = json{
				var result : [ProfileDTO] = []
				let datas = json["data"].arrayValue
				
				for data in datas{
					let profile = ProfileDTO.init(fromJSON: data)
					result.append(profile)
				}
				completion(result)
				
			}else{
				completion(nil)
			}
			
		}
	}
	
	func notification(completion : @escaping (Array<Notification>?) -> Void){
		
		MainAPI.requestNotification{json in
			if let json = json{
				var result : [Notification] = []
				
				for data in json["data"].arrayValue{
					
					let notification = Notification.init(fromJson: data)
					
					result.append(notification)
					
					
				}
				
				completion(result)
			}else{
				completion(nil)
			}
		}
	}
}
