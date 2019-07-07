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
