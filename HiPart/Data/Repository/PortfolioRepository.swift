import Foundation

import SwiftyJSON

class PortfolioRepository{
	static let shared = PortfolioRepository()
	private init() {}

	func creatorDetail(completion : @escaping (ProfileDetailDTO?) -> Void ){
		PortfolioAPI.requestCreatorDetail{json in
			if let json = json{
				completion(ProfileDetailDTO.init(fromJSON: json["data"], type: .Creator,fromProfile: false))
			}else{
				completion(nil)
			}
		}
	}
	func editorDetail(completion : @escaping (ProfileDetailDTO?) -> Void){
		PortfolioAPI.requestEditorDetail{json in
			if let json = json{
				completion(ProfileDetailDTO.init(fromJSON: json["data"], type: .Creator,fromProfile: false))
			}else{
				completion(nil)
			}
		}
	}
	func translatorDetail(completion : @escaping (ProfileDetailDTO?) -> Void){
		PortfolioAPI.requestTranslatorDetail{json in
			if let json = json{
				completion(ProfileDetailDTO.init(fromJSON: json["data"], type: .Creator,fromProfile: false))
			}else{
				completion(nil)
			}
		}
	}
	func etcDetail(completion : @escaping (ProfileDetailDTO?) -> Void){
		PortfolioAPI.requestEtcDetail{json in
			if let json = json{
				completion(ProfileDetailDTO.init(fromJSON: json["data"], type: .Creator,fromProfile: false))
			}else{
				completion(nil)
			}
		}
	}
	
	
	func creatorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String,completion : @escaping (JSON?) -> Void) {
		PortfolioAPI.requestCreatorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content,completion: completion)
	}
	func editorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String,completion : @escaping (JSON?) -> Void) {
		PortfolioAPI.requestEditorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content,completion: completion)
	}
	func etcUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String,completion : @escaping (JSON?) -> Void) {
		PortfolioAPI.requestEtcUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content,completion: completion)
	}
	func translatorUpload(before : String, after:String,completion : @escaping (JSON?) -> Void) {
		PortfolioAPI.requestTranslatorUpload(before : before, after : after,completion: completion)
	}
}
