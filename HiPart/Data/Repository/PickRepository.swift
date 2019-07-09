//
//  MainRepository.swift
//  HiPart
//
//  Created by 최은희 on 09/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON


class PickRepository{
	static let shared = PickRepository()
	private init(){
		
	}

	func pickAdd(nickname : String) -> Single<Bool>{
		return PickAPI.requestPickAdd(nickname: nickname).map{json in
			return json["success"].boolValue
		}
	}
	func pickDelete(nickname : String) -> Single<Bool>{
		return PickAPI.requestPickDelete(nickname: nickname).map{json in
			debugE(json)
			return json["success"].boolValue
		}
	}
	func pickGet() -> Single<Array<ProfileDTO>>{
		return PickAPI.requestPickGet().map{json in
			var result : [ProfileDTO] = []
			for data in json["data"].arrayValue{
				let profile = ProfileDTO.init(fromJSON: data)
				result.append(profile)
			}
			return result
		}
	}
}
