import Foundation
import RxSwift
import SwiftyJSON

class ProfileRepository{
	static let shared = ProfileRepository()
	private init(){}
	
	
	func list(flag : ProfileFlag) -> Single<Array<ProfileDTO>>{
		
		return ProfileAPI.requestList(flag: flag).map{json in
			
			var result : [ProfileDTO] = []
			let datas = json["data"].arrayValue
			
			for data in datas{
				let profile = ProfileDTO.init(fromJSON: data)
				result.append(profile)
			}
			
			return result
			
		}
		
	}
	
	func detail(nickname : String ,type : UserType) -> Single<ProfileDetailDTO>{
		return ProfileAPI.requestDetail(nickname: nickname).map{json in
			let profileDetail = ProfileDetailDTO.init(fromJSON: json["data"],type: type)
			
			return profileDetail
		}
	}
}
