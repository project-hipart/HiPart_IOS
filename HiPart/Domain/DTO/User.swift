
import Foundation

struct User : Codable{
	var email : String
	var nickname : String
	var password : String
	var number : String
	var type : Int
	
	enum CodingKeys: String, CodingKey {
		case email = "user_email"
		case nickname = "user_nickname"
		case password = "user_pw"
		case number = "user_number"
		case type = "user_type"
	}
}

enum UserType : Int{
	case Creator = 1
	case PD = 2
	case Translator = 3
	case Etc = 4
}
