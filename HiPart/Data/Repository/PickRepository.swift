//
//  MainRepository.swift
//  HiPart
//
//  Created by 최은희 on 09/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation

import SwiftyJSON


class PickRepository{
	static let shared = PickRepository()
	private init(){
		
	}
	
	func pickAdd(nickname : String, completion : @escaping (Bool?) -> Void){
		
		PickAPI.requestPickAdd(nickname: nickname){json in
			if let json = json{
				completion(json["success"].boolValue)
			}else{
				completion(nil)
			}
		}
	}
	func pickDelete(nickname : String, completion : @escaping (Bool?) -> Void){
		
		PickAPI.requestPickDelete(nickname: nickname){json in
			if let json = json{
				completion(json["success"].boolValue)
			}else{
				completion(nil)
			}
		}
		
	}
	func pickGet(completion : @escaping (Array<ProfileDTO>?) -> Void){
		PickAPI.requestPickGet{json in
			if let json = json{
				
				var result : [ProfileDTO] = []
				for data in json["data"].arrayValue{
					let profile = ProfileDTO.init(fromJSON: data)
					result.append(profile)
				}
				
				completion(result)
			}else{
				completion(nil)
			}
		}
	}
}
