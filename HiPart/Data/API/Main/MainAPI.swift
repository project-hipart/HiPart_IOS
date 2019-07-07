import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

enum MainAPI : APIConfiguration{
	case search(keyword : String)
	
	var method: HTTPMethod{
		switch self{
		case .search:
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .search(let keyword):
			return "/main/search/\(keyword)"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .search(let keyword):
			return [APIKeys.mainKeyword : keyword]
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .search:
			return ContentType.json
		}
	}
	
	static func requestSearch(keyword : String) -> Single<JSON>{
		return APIClient.request(api: MainAPI.search(keyword: keyword))
	}
}
