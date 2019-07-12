import Foundation
import Alamofire
import SwiftyJSON

class APIClient{
	
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
		}
	}
	
}
