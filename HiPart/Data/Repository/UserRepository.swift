
import Foundation


class UserRepository{
	static let shared = UserRepository()
	private init() {}
	
	var myType : UserType!
}
