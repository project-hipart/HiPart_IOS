import Foundation
import Alamofire
import SwiftyJSON

enum ProfileFlag : Int{
	case All = 0
	case Creator = 1
	case PD = 2
	case Translator = 3
	case ETC = 4
	
}

enum ProfileAPI : APIConfiguration{
	case list(flag : ProfileFlag)
	case detail(nickname : String)
	case recommend
	
	var method: HTTPMethod{
		switch self{
		default:
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .list(let flag):
			return "/profile/list/\(flag.rawValue)"
		case .detail(let nickname):
			return "/profile/detail/\(nickname)"
		case .recommend:
			return "/profile/recommend"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .list(let flag):
			return [APIKeys.profileFlag : flag.rawValue]
		case .detail(let nickname):
			return nil
		default:
			return nil
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .list,.detail,.recommend:
			return ContentType.json
		}
	}
	
	static func requestList(flag : ProfileFlag,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: ProfileAPI.list(flag: flag),completion : completion)
	}
	static func requestDetail(nickname : String,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: ProfileAPI.detail(nickname: nickname),completion : completion)
	}
	static func requestRecommend(completion : @escaping ((JSON?) -> Void)){
		return APIClient.request(api: ProfileAPI.recommend, completion: completion)
	}
}
