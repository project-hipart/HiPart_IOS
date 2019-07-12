import Foundation
import SwiftyJSON

class ProfileRepository{
	static let shared = ProfileRepository()
	private init(){}
	
	
	func list(flag : ProfileFlag, completion : @escaping (Array<ProfileDTO>?) -> Void){
		
		ProfileAPI.requestList(flag: flag){json in
			
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
	
	func detail(nickname : String ,type : UserType, completion : @escaping (ProfileDetailDTO?) -> Void){
		
		ProfileAPI.requestDetail(nickname: nickname){json in
			if let json = json{
				let profileDetail = ProfileDetailDTO.init(fromJSON: json["data"],type: type,fromProfile: true)
				completion(profileDetail)
			}else{
				completion(nil)
			}
			
		}
	}
	
	func recommend(completion : @escaping (Array<ProfileDTO>?) -> Void){
		ProfileAPI.requestRecommend{json in
			if let json = json{
				var result : [ProfileDTO] = []
				for data in json["data"]["resData"].arrayValue{
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
