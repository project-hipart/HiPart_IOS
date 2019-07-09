import RxSwift
import Foundation
import SwiftyJSON
class HifiveRepositoy{
	public static let shared = HifiveRepositoy()
	private init(){}

	func contact(nickname : String) -> Single<JSON>{
		return HifiveAPI.requestContact(nickname: nickname)
	}
	func number(nickname : String) -> Single<JSON>{
		return HifiveAPI.requestNumber(nickname: nickname)
	}
}
