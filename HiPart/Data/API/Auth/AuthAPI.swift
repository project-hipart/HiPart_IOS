import Alamofire
import RxSwift
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
	case signUp(email:String, nickname : String, img : Data,password : String, number : String, type : Int)
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
			return ["user_email": email, "user_pw": password]
		case .signUp, .duplicateCheck ,.findId,.findPassword,.refresh:
			return nil
		}
	}

	static func requestSignIn(email : String, password : String) -> Single<JSON>{
		
		let api = AuthAPI.signIn(email: email, password: password)
		let url = api.path.attachBaseURL()
		
		return Single.create{single in
			Alamofire.request(url, method: api.method, parameters: api.parameters, encoding: JSONEncoding(), headers: nil)
				.validate(statusCode: 200..<300)
				.responseJSON { response in
					
					switch response.result {
					case .success:
						guard let data = response.data else {
							single(.error(AFError.responseValidationFailed(reason: .dataFileNil)))
							return
						}
						
						let json = try? JSON(data: data)
						single(.success(json!))
					case .failure(let error):
						single(.error(error))
					}
					
			}
			
			return Disposables.create()
		}
	}
	
	static func requestSignUp(email : String, nickname : String, img : Data, password : String, number : String, type : Int) -> Single<JSON>{
		let api = AuthAPI.signUp(email: email, nickname: nickname, img: img, password: password, number: number, type: type)
		let url = api.path.attachBaseURL()
		
		return Single.create{single in
			
			Alamofire.upload(multipartFormData: { multipartFormData in
				
			}, to: url , encodingCompletion: <#T##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##(SessionManager.MultipartFormDataEncodingResult) -> Void#>)
			
			
			return Disposables.create()
		}
	}
	
	static func requestDuplicateCheck(flag : DuplicateCheckFlag,input : String) -> Single<JSON>{
		let api = AuthAPI.duplicateCheck(flag: flag.rawValue, input: input)
		let url = api.path.attachBaseURL()
		
		return Single.create{single in
			Alamofire.request(url, method: api.method, parameters: api.parameters, encoding: JSONEncoding(), headers: nil)
				.validate(statusCode: 200..<300)
				.responseJSON { response in
					
					switch response.result {
					case .success:
						guard let data = response.data else {
							single(.error(AFError.responseValidationFailed(reason: .dataFileNil)))
							return
						}
						
						let json = try? JSON(data: data)
						single(.success(json!))
					case .failure(let error):
						single(.error(error))
					}
					
			}
			
			return Disposables.create()
		}
	}
	
	
	
}
