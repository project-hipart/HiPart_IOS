import Foundation
import RxSwift
import SwiftyJSON

class ProfileRepository{
	static let shared = ProfileRepository()
	private init(){}
	
	
	func list(flag : ProfileFlag) -> Single<Array<ProfileDTO>>{
		return ProfileAPI.requestList(flag: flag).map{json in
			
			debugE(json)

			var result : [ProfileDTO] = []
			let datas = json["data"].arrayValue
			
			for data in datas{
				let profile = ProfileDTO.init(fromJSON: data)
				result.append(profile)
			}
			
			return result
		}
	}
}
