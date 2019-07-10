import Foundation
<<<<<<< HEAD
import RxSwift
=======

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
import SwiftyJSON

class ProfileRepository{
	static let shared = ProfileRepository()
	private init(){}
	
	
<<<<<<< HEAD
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
	
	func detail(nickname : String) -> Single<ProfileDetailDTO>{
		return ProfileAPI.requestDetail(nickname: nickname).map{json in
			
			let profileDetail = ProfileDetailDTO.init(fromJSON: json)
			
			return profileDetail
=======
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
			
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		}
	}
}
