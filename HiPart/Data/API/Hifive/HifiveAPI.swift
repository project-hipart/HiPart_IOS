import Foundation
import Alamofire

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
	
	static func requestContact(nickname : String,completion : @escaping (JSON?) -> Void) {
		return APIClient.request(api: HifiveAPI.contact(nickname: nickname) ,encoding: URLEncoding.httpBody,completion : completion)
	}
	static func requestNumber(nickname : String,completion : @escaping (JSON?) -> Void) {
		return APIClient.request(api: HifiveAPI.number(nickname: nickname),completion : completion)
	}
	
	
	
	
}
