import Foundation
import RxSwift
import SwiftyJSON

class PortfolioRepository{
	static let shared = PortfolioRepository()
	private init() {}

	func creatorDetail() -> Single<ProfileDetailDTO>{
		return PortfolioAPI.requestCreatorDetail().map{json in
			return ProfileDetailDTO.init(fromJSON: json["data"], type: .Creator)
		}
	}
	func editorDetail() -> Single<ProfileDetailDTO>{
		return PortfolioAPI.requestEditorDetail().map{json in
			return ProfileDetailDTO.init(fromJSON: json["data"], type: .PD)
		}
	}
	func translatorDetail() -> Single<ProfileDetailDTO>{
		return PortfolioAPI.requestTranslatorDetail().map{json in
			return ProfileDetailDTO.init(fromJSON: json["data"], type: .Translator)
		}
	}
	func etcDetail() -> Single<ProfileDetailDTO>{
		return PortfolioAPI.requestEtcDetail().map{json in
			return ProfileDetailDTO.init(fromJSON: json["data"], type: .Etc)
		}
	}
	
	
	func creatorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return PortfolioAPI.requestCreatorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content)
	}
	func editorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return PortfolioAPI.requestEditorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content)
	}
	func etcUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return PortfolioAPI.requestEtcUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content)
	}
	func translatorUpload(before : String, after:String) -> Single<JSON>{
		return PortfolioAPI.requestTranslatorUpload(before : before, after : after)
	}
}
