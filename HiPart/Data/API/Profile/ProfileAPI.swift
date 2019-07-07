import Foundation
import Alamofire
import RxSwift
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
	
	var method: HTTPMethod{
		switch self{
		case .list:
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .list(let flag):
			return "/profile/list/\(flag.rawValue)"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .list(let flag):
			return [APIKeys.profileFlag : flag.rawValue]
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .list:
			return ContentType.json
		}
	}
	
	static func requestList(flag : ProfileFlag) -> Single<JSON>{
		return APIClient.request(api: ProfileAPI.list(flag: flag))
	}
}
