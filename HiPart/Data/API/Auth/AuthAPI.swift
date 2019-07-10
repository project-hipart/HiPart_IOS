import Alamofire

import SwiftyJSON

class AFDataError : Error{
	
}

enum DuplicateCheckFlag : Int{
	case email = 1
	case nickname = 2
}
enum DuplicateCheckResult : Int{
	case duplicate = 1
	case noDuplicate = 0
}

enum AuthAPI : APIConfiguration{
	
	case signIn(email:String, password:String)
	case signUp(email:String, nickname : String, img : Data,imageUrl : String,password : String, number : String, type : Int)
	case duplicateCheck(flag : Int, input : String)
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
			return [APIKeys.userEmail: email, APIKeys.userPassword: password]
			
		case .signUp(let email, let nickname, let img,let imageUrl, let password, let number, let type):
			return [APIKeys.userEmail : email, APIKeys.userNickname : nickname, APIKeys.userImage : img, APIKeys.imageUrl : imageUrl,
					APIKeys.userPassword : password, APIKeys.userNumber : number, APIKeys.userType : type]
			
		case .duplicateCheck(let flag, let input) :
			return [APIKeys.duplicateCheckFlag : flag, APIKeys.duplicateCheckInput : input]
			
		default:
			return nil
		}
	}
	
	var contentType: ContentType{
		switch self{
		case .signUp:
			return ContentType.multipart
		default:
			return ContentType.json
		}
	}

	
	static func requestSignIn(email : String, password : String, completion : @escaping (JSON?) -> Void) {
		return APIClient.request(api: AuthAPI.signIn(email: email, password: password),completion : completion)
	}
	
	static func requestSignUp(email : String, nickname : String, img : Data,imageUrl : String, password : String, number : String, type : Int, completion : @escaping (JSON?) -> Void) {
		return APIClient.request(api: AuthAPI.signUp(email: email, nickname: nickname, img: img,imageUrl : imageUrl, password: password, number: number, type: type),completion : completion)
	}
	
	static func requestDuplicateCheck(flag : DuplicateCheckFlag,input : String, completion : @escaping (JSON?) -> Void) {
		return APIClient.request(api: AuthAPI.duplicateCheck(flag: flag.rawValue, input: input),completion : completion)
	}
	
	
	
}
