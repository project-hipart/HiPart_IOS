import Foundation

struct APIConstants {
	static let baseURL = "http://192.168.0.28:3000"
	
	
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
