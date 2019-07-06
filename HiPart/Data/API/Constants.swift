import Foundation

struct K {
	struct ProductionServer {
		static let baseURL = "pending..."
	}
	
	struct APIParameterKey {
		static let password = "password"
		static let email = "email"
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
