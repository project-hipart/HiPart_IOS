import Alamofire

protocol APIConfiguration {
	var method: HTTPMethod { get }
	var path: String { get }
	var parameters: Parameters? { get }
	var contentType : ContentType {get}
}
