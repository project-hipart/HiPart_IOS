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
<<<<<<< HEAD
=======
	static func getPickedStateWithBool(_ picked : Bool) -> PickState{
		if picked{
			return .pick
		}else{
			return .unPick
		}
	}
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
}
