import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

enum MainAPI : APIConfiguration{
	case search(keyword : String)
	case notification
	
	var method: HTTPMethod{
		switch self{
		case .search,.notification:
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .search(let keyword):
			return "/main/search/\(keyword)"
		case .notification:
			return "/main/notification"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .search(let keyword):
			return [APIKeys.mainKeyword : keyword]
		case .notification:
			return nil
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .search,.notification:
			return ContentType.json
			
		}
	}
	
	static func requestSearch(keyword : String) -> Single<JSON>{
		return APIClient.request(api: MainAPI.search(keyword: keyword))
	}
	static func requestNotification() -> Single<JSON>{
		return APIClient.request(api: MainAPI.notification)
	}
}
