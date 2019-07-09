import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


enum PickAPI : APIConfiguration{
	case pickAdd(nickname : String)
	case pickDelete(nickname : String)
	case pickGet
	
	var method: HTTPMethod{
		switch self{
		case .pickAdd:
			return .post
		case .pickDelete:
			return .delete
		case .pickGet:
			return .get
		}
	}
	
	var path: String{
		switch self{
		default:
			return "/pick"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .pickAdd(let nickname):
			return [APIKeys.nickname:nickname]
		case .pickDelete(let nickname):
			return [APIKeys.nickname:nickname]
		case .pickGet:
			return nil
		}
	}
	
	var contentType: ContentType{
		switch self{
		default:
			return ContentType.json
		}
	}
	
	static func requestPickAdd(nickname : String) -> Single<JSON>{
		return APIClient.request(api: PickAPI.pickAdd(nickname: nickname))
	}
	static func requestPickDelete(nickname : String) -> Single<JSON>{
		return APIClient.request(api: PickAPI.pickDelete(nickname: nickname),encoding: URLEncoding.httpBody)
	}
	static func requestPickGet() -> Single<JSON>{
		return APIClient.request(api: PickAPI.pickGet)
	}
	
}
