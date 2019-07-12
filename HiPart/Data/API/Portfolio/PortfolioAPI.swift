import Foundation
import Alamofire

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
	
	//EDIT
	case edit(platform : Int, subscriber : String, oneline : String, want : String, appeal : String, concept : Int, lang : Int, pd : Int, etc : Int)
	var method: HTTPMethod{
		switch self{
		case .creatorUpload,.editorUpload,.etcUpload,.translatorUpload:
			return .post
		case .creatorDetail,.editorDetail,.translatorDetail,.etcDetail:
			return .get
		case .edit:
			return .put
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
		case .edit:
			return "/portfolio/detail"
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
		case .edit(let platform,let subscriber,let oneline,let want,let appeal,let concept, let lang, let pd, let etc):
			return ["detail_platform" : platform, "detail_subscriber" : subscriber,
					"detail_oneline" : oneline, "detail_want" : want, "detail_appeal" : appeal,
					APIKeys.concept : concept, APIKeys.lang : lang, APIKeys.pd : pd, APIKeys.etc : etc]
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
	
	static func requestCreatorDetail(completion : @escaping ((JSON?) -> Void)){
		return APIClient.request(api: PortfolioAPI.creatorDetail,completion : completion)
	}
	static func requestEditorDetail(completion : @escaping ((JSON?) -> Void)){
		return APIClient.request(api: PortfolioAPI.editorDetail,completion : completion)
	}
	static func requestTranslatorDetail(completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: PortfolioAPI.translatorDetail,completion : completion)
	}
	static func requestEtcDetail(completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: PortfolioAPI.etcDetail,completion : completion)
	}
	
	static func requestCreatorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: PortfolioAPI.creatorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content),completion : completion)
	}
	static func requestEditorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: PortfolioAPI.editorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content),completion : completion)
	}
	static func requestEtcUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: PortfolioAPI.etcUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content),completion : completion)
	}
	static func requestTranslatorUpload(before : String, after : String,completion : @escaping ((JSON?) -> Void)) {
		return APIClient.request(api: PortfolioAPI.translatorUpload(before: before, after: after),completion : completion)
	}
	
	static func requestEdit(edit : PortfolioAPI, completion : @escaping (JSON?) -> Void){
		return APIClient.request(api: edit, completion: completion)
	}
	
}
