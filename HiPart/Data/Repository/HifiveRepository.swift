
import Foundation
import SwiftyJSON
class HifiveRepositoy{
	public static let shared = HifiveRepositoy()
	private init(){}

	func contact(nickname : String, completion : @escaping (JSON?) -> Void){
		HifiveAPI.requestContact(nickname: nickname,completion: completion)
	}
	func number(nickname : String, completion : @escaping (JSON?) -> Void) {
		HifiveAPI.requestNumber(nickname: nickname,completion: completion)
	}
}
