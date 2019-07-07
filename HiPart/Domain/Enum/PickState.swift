enum PickState : Int{
	case pick = 1
	case unPick = 0
	
	func getPicked() -> Bool{
		switch self{
		case .pick:
			return true
		case .unPick:
			return false
		}
	}
}
