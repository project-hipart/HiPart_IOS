import Foundation

struct APIConstants {
	static let baseURL = "http://52.78.120.232:3000"
}
struct APIKeys{
	//Common
	static let imageUrl = "imageUrl"
	
	//Auth
	static let userEmail = "user_email"
	static let userNickname = "user_nickname"
	static let userImage = "user_img"
	static let userPassword = "user_pw"
	static let userNumber = "user_number"
	static let userType = "user_type"
	static let duplicateCheckFlag = "flag"
	static let duplicateCheckInput = "input"
	
	//Main
	static let mainKeyword = "keyword"
	
	//Profile
	static let profileFlag = "flag"
	static let userIndex = "user_idx"
	static let pickState = "pickState"
	static let pick = "pick"
	static let detailFlatform = "detail_platform"
	static let detailOneLine = "detail_oneline"
	static let detailSubscriber = "detail_subscriber"
	static let detailAppeal = "detail_appeal"
	static let detailWant = "detail_want"
	static let workIndex = "work_idx"
	static let thumbnail = "thumbnail"
	static let before = "before"
	static let after = "after"
	static let url = "url"
	static let title = "title"
	static let content = "content"
	static let concept = "concept"
	static let lang = "lang"
	static let pd = "pd"
	static let etc = "etc"
	static let hifiveState = "hifiveState"
	static let hifive = "hifive"
}

extension String{
	func attachBaseURL() -> String{
		return APIConstants.baseURL + self
	}
}

enum HTTPHeaderField: String {
	case authentication = "Authorization"
	case contentType = "Content-Type"
	case acceptType = "Accept"
	case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
	case json = "application/json"
	case multipart = "multipart/form-data"
}
enum MimeType: String{
	case image = "image/jpeg"
}
