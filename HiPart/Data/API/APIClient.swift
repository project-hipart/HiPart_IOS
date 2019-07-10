import Foundation
<<<<<<< HEAD
import RxSwift
=======
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
import Alamofire
import SwiftyJSON

class APIClient{
	
<<<<<<< HEAD
	static func request(api : APIConfiguration) -> Single<JSON>{
		switch api.contentType{
			
		case ContentType.json:
			return requestJSON(api: api)
		case ContentType.multipart:
			return requestMultipartForm(api: api)
		default:
			fatalError()
		}
		
	}
	
	private static func requestJSON(api : APIConfiguration) -> Single<JSON>{
		let url = api.path.attachBaseURL()
		
		return Single.create{single in
			
			let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			
			if urlEncoded == nil{
				single(.error(AFError.invalidURL(url: url)))
			}else{
				Alamofire.request(urlEncoded!, method: api.method, parameters: api.parameters, encoding: URLEncoding.default, headers: TokenHelper.getCommonHeader())
					.validate(statusCode: 200..<300)
					.validate(contentType: [ContentType.json.rawValue])
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
			}
			
			return Disposables.create()
		}
	}
	
	private static func requestMultipartForm(api : APIConfiguration) -> Single<JSON>{
		let url = api.path.attachBaseURL()
		let params : [String:Any] = api.parameters ?? [:]
		
		return Single.create{single in
			
			let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			
			if urlEncoded == nil{
				single(.error(AFError.invalidURL(url: url)))
			}else{
				Alamofire.upload(multipartFormData: { multipartFormData in
					
					for (key, value) in params{
						if value is String || value is Int {
							multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
						}
						if value is Data{
							let fileName = params[APIKeys.imageUrl] as! String
							
							multipartFormData.append(value as! Data, withName: key, fileName: fileName, mimeType: "image/jpeg")
						}
					}
					
					
					
				}, to: urlEncoded! , encodingCompletion:{ encodingResult in
					switch encodingResult {
					case .success(let upload, _, _):
						
						
						upload.responseJSON { response in
							switch response.result {
							case .success:
								guard let data = response.data else {
									single(.error(AFError.responseValidationFailed(reason: .dataFileNil)))
									return
								}
								
								
								let json = try? JSON(data: data)
								single(.success(json!))
							case .failure(let error):
								debugE(error)
								single(.error(error))
							}
						}
					case .failure(let encodingError):
						debugE(encodingError)
					}
				})
			}
			return Disposables.create()
=======
	fileprivate static let ALAMOFIREMANAGER: SessionManager = {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 10
		configuration.timeoutIntervalForResource = 10
		let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
		return alamoFireManager
		
	}()
	
	static func request(api : APIConfiguration,encoding : ParameterEncoding = URLEncoding.default,  completion : @escaping ((JSON?) -> Void)){
		switch api.contentType{
			
		case ContentType.json:
			return requestJSON(api: api,encoding: encoding, completion: completion)
		case ContentType.multipart:
			return requestMultipartForm(api: api,encoding: encoding, completion: completion)
		}
	}
	
	private static func requestJSON(api : APIConfiguration,encoding : ParameterEncoding = URLEncoding.default,completion : @escaping ((JSON?) -> Void)){
		let url = api.path.attachBaseURL()
		
		
		let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		if urlEncoded == nil{
			completion(nil)
		}else{
			ALAMOFIREMANAGER.request(urlEncoded!, method: api.method, parameters: api.parameters, encoding: encoding, headers: TokenHelper.getCommonHeader())
				.validate(statusCode: 200..<300)
				.validate(contentType: [ContentType.json.rawValue])
				.responseJSON { response in
					switch response.result {
					case .success:
						
						guard let data = response.data else {
							completion(nil)
							return
						}
						
						let json = try? JSON(data: data)
						completion(json!)
					case .failure(let error):
						debugE(error)
						completion(nil)
					}
			}
		}
		
	}
	
	private static func requestMultipartForm(api : APIConfiguration,encoding : ParameterEncoding = URLEncoding.default,completion : @escaping ((JSON?) -> Void)){
		let url = api.path.attachBaseURL()
		let params : [String:Any] = api.parameters ?? [:]
		
		
		let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		if urlEncoded == nil{
			completion(nil)
		}else{
			ALAMOFIREMANAGER.upload(multipartFormData: { multipartFormData in
				
				for (key, value) in params{
					if value is String || value is Int {
						multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
					}
					if value is Data{
						let fileName = params[APIKeys.imageUrl] as! String
						
						multipartFormData.append(value as! Data, withName: key, fileName: fileName, mimeType: "image/jpeg")
					}
				}
				
			}, to: urlEncoded!,headers: TokenHelper.getCommonHeader() , encodingCompletion:{ encodingResult in
				switch encodingResult {
				case .success(let upload, _, _):
					
					
					upload.responseJSON { response in
						switch response.result {
						case .success:
							guard let data = response.data else {
								completion(nil)
								return
							}
							
							
							let json = try? JSON(data: data)
							completion(json!)
						case .failure(let error):
							debugE(error)
							completion(nil)
						}
					}
				case .failure(let encodingError):
					completion(nil)
					debugE(encodingError)
				}
			})
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		}
	}
	
}
