import Alamofire

enum AuthAPI: APIConfiguration {
	
	case signIn(email:String, password:String)
	case signUp
	case duplicateCheck(flag : String, input : String)
	case findId(input : String)
	case findPassword(input : String)
	case refresh
	
	// MARK: - HTTPMethod
	var method: HTTPMethod {
		switch self {
		case .signIn,.signUp:
			return .post
		case .duplicateCheck,.findId,.findPassword,.refresh:
			return .get
		}
	}
	
	// MARK: - Path
	var path: String {
		switch self {
		case .signIn:
			return "/auth/signin"
		case .signUp:
			return "/auth/signup"
		case .duplicateCheck(let flag, let input) :
			return "/auth/duplicated/\(flag)/\(input)"
		case .findId(let input):
			return "/auth/finder/id/\(input)"
		case .findPassword(let input):
			return "/auth/finder/pwd/\(input)"
		case .refresh:
			return "/auth/refresh"
			
		}
	}
	
	// MARK: - Parameters
	var parameters: Parameters? {
		switch self {
		case .signIn(let email, let password):
			return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
		case .signUp, .duplicateCheck ,.findId,.findPassword,.refresh:
			return nil
		}
	}
	
	var contentType: String{
		switch self{
		case .signIn,.duplicateCheck,.findId,.findPassword,.refresh:
			return ContentType.json.rawValue
		case .signUp:
			return ContentType.multipart.rawValue
		}
	}
	
	// MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		let url = try K.ProductionServer.baseURL.asURL()
		
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		
		// HTTP Method
		urlRequest.httpMethod = method.rawValue
		
		// Common Headers
		urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
		urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
		
		// Parameters
		if let parameters = parameters {
			do {
				urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
			} catch {
				throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
			}
		}
		
		return urlRequest
	}
}
