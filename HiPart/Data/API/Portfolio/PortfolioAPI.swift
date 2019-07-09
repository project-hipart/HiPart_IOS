import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


enum PortfolioAPI : APIConfiguration{
	
	case creatorUpload(thumbnail : Data,thumbnailUrl : String,url : String, title : String, content : String)
	
	var method: HTTPMethod{
		switch self{
		case .creatorUpload:
			return .post
		}
	}
	
	var path: String{
		switch self{
		case .creatorUpload:
			return "/portfolio/creator"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .creatorUpload(let thumbnail,let thumbnailUrl,let url,let title ,let content):
			return [APIKeys.thumbnail : thumbnail,APIKeys.imageUrl : thumbnailUrl , APIKeys.url : url, APIKeys.title: title, APIKeys.content : content ]
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .creatorUpload:
			return .multipart
		}
	}
	
	static func requestCreatorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.creatorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content))
	}
}
