import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


enum PortfolioAPI : APIConfiguration{
	
	//DETAILS
	case creatorDetail
	case editorDetail
	case translatorDetail
	case etcDetail
	
	
	
	//UPLOADS
	case creatorUpload(thumbnail : Data,thumbnailUrl : String,url : String, title : String, content : String)
	case editorUpload(thumbnail : Data,thumbnailUrl : String,url : String, title : String, content : String)
	case etcUpload(thumbnail : Data,thumbnailUrl : String,url : String, title : String, content : String)
	case translatorUpload(before : String, after: String)
	
	var method: HTTPMethod{
		switch self{
		case .creatorUpload,.editorUpload,.etcUpload,.translatorUpload:
			return .post
		case .creatorDetail,.editorDetail,.translatorDetail,.etcDetail:
			return .get
		}
	}
	
	var path: String{
		switch self{
		case .creatorUpload:
			return "/portfolio/creator"
		case .editorUpload:
			return "/portfolio/editor"
		case .etcUpload:
			return "/portfolio/etc"
		case .translatorUpload:
			return "/portfolio/translator"
		case .creatorDetail:
			return "/portfolio/detail/creator"
		case .editorDetail:
			return "/portfolio/detail/editor"
		case .translatorDetail:
			return "/portfolio/detail/translator"
		case .etcDetail:
			return "/portfolio/detail/etc"
		}
	}
	
	var parameters: Parameters?{
		switch self{
		case .creatorUpload(let thumbnail,let thumbnailUrl,let url,let title ,let content):
			return [APIKeys.thumbnail : thumbnail,APIKeys.imageUrl : thumbnailUrl , APIKeys.url : url, APIKeys.title: title, APIKeys.content : content ]
		case .editorUpload(let thumbnail,let thumbnailUrl,let url,let title ,let content):
			return [APIKeys.thumbnail : thumbnail,APIKeys.imageUrl : thumbnailUrl , APIKeys.url : url, APIKeys.title: title, APIKeys.content : content ]
		case .etcUpload(let thumbnail,let thumbnailUrl,let url,let title ,let content):
			return [APIKeys.thumbnail : thumbnail,APIKeys.imageUrl : thumbnailUrl , APIKeys.url : url, APIKeys.title: title, APIKeys.content : content ]
		case .translatorUpload(let before, let after):
			return [APIKeys.before : before, APIKeys.after : after]
		default:
			return nil
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .creatorUpload,.editorUpload,.etcUpload:
			return .multipart
		default:
			return .json
		}
	}
	
	static func requestCreatorDetail() -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.creatorDetail)
	}
	static func requestEditorDetail() -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.editorDetail)
	}
	static func requestTranslatorDetail() -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.translatorDetail)
	}
	static func requestEtcDetail() -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.etcDetail)
	}
	
	static func requestCreatorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.creatorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content))
	}
	static func requestEditorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.editorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content))
	}
	static func requestEtcUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.etcUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content))
	}
	static func requestTranslatorUpload(before : String, after : String) -> Single<JSON>{
		return APIClient.request(api: PortfolioAPI.translatorUpload(before: before, after: after))
	}
	
	
}
