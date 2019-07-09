import Foundation
import RxSwift
import SwiftyJSON

class PortfolioRepository{
	static let shared = PortfolioRepository()
	private init() {}

	func creatorUpload(thumbnail : Data, thumbnailUrl : String, url : String, title : String, content : String) -> Single<JSON>{
		return PortfolioAPI.requestCreatorUpload(thumbnail: thumbnail, thumbnailUrl: thumbnailUrl, url: url, title: title, content: content)
	}
}
