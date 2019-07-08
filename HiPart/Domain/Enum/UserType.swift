import Foundation

enum UserType : Int{
	case All = 0
	case Creator = 1
	case PD = 2
	case Translator = 3
	case Etc = 4
	
	var name : String{
		switch self{
		case .Creator:
			return "크리에이터"
		case .PD:
			return "PD"
		case .Translator:
			return "번역가"
		case .Etc:
			return "기타"
		default:
			return ""
		}
	}
}
