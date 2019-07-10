import Foundation
import Alamofire
<<<<<<< HEAD
import RxSwift
=======

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
import SwiftyJSON

enum MainAPI : APIConfiguration{
	case search(keyword : String)
<<<<<<< HEAD
	
	var method: HTTPMethod{
		switch self{
		case .search:
=======
	case notification
	
	var method: HTTPMethod{
		switch self{
		case .search,.notification:
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .search(let keyword):
			return "/main/search/\(keyword)"
<<<<<<< HEAD
=======
		case .notification:
			return "/main/notification"
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .search(let keyword):
			return [APIKeys.mainKeyword : keyword]
<<<<<<< HEAD
=======
		case .notification:
			return nil
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		}
	}
	
	var contentType: ContentType{
		switch self{
<<<<<<< HEAD
		case .search:
			return ContentType.json
		}
	}
	
	static func requestSearch(keyword : String) -> Single<JSON>{
		return APIClient.request(api: MainAPI.search(keyword: keyword))
=======
		case .search,.notification:
			return ContentType.json
			
		}
	}
	
	static func requestSearch(keyword : String,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: MainAPI.search(keyword: keyword),completion : completion)
	}
	static func requestNotification(completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: MainAPI.notification,completion : completion)
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	}
}
