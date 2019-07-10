import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


enum HifiveAPI : APIConfiguration{
	case contact(nickname : String)
	case number(nickname : String)
	
	var method: HTTPMethod{
		switch self{
		case .contact:
			return .post
		case .number:
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .contact:
			return "/hifive"
		case .number(let nickname):
			return "/hifive/\(nickname)"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .contact(let nickname):
			return [APIKeys.nickname : nickname]
		case .number(let nickname):
			return [APIKeys.nickname : nickname]
		}
	}
	
	var contentType: ContentType{
		switch self{
		default:
			return .json
		}
	}
	
	static func requestContact(nickname : String) -> Single<JSON>{
		return APIClient.request(api: HifiveAPI.contact(nickname: nickname) ,encoding: URLEncoding.httpBody)
	}
	static func requestNumber(nickname : String) -> Single<JSON>{
		return APIClient.request(api: HifiveAPI.number(nickname: nickname))
	}
	
	
	
	
}
