
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class APIClient{
	
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
		}
	}
	
}
