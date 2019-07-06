import Alamofire

protocol APIConfiguration: URLRequestConvertible {
	var method: HTTPMethod { get }
	var path: String { get }
	var parameters: Parameters? { get }
	var contentType : String {get}
}
