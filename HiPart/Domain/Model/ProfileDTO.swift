import Foundation
import SwiftyJSON


class ProfileDTO{
	var pickState : PickState
	
	let index : Int
	let nickname : String
	let image : String
	let type : UserType
	var pickCount : Int
	let platform : Platform
	let oneLine : String
	
	let broadcastConcept : Filter?
	let language : Filter?
	let pd : Filter?
	let etc : Filter?
	
	init(fromJSON : JSON){
		pickState = PickState(rawValue: fromJSON[APIKeys.pickState].intValue)!
		
		let info = fromJSON["info"].arrayValue[0]
		index = info[APIKeys.userIndex].intValue
		image = info[APIKeys.userImage].stringValue
		nickname = info[APIKeys.userNickname].stringValue
		
		type = UserType(rawValue: info[APIKeys.userType].intValue)!
		pickCount = info[APIKeys.pick].intValue
		platform = Platform(rawValue:info[APIKeys.detailFlatform].intValue)!
		oneLine = info[APIKeys.detailOneLine].stringValue
		
		broadcastConcept = Filter.getFilterWithGroupAndIndex(.BroadcastConcept,  info[APIKeys.concept].intValue)
		pd = Filter.getFilterWithGroupAndIndex(.PD,  info[APIKeys.pd].intValue)
		language = Filter.getFilterWithGroupAndIndex(.Language,  info[APIKeys.lang].intValue)
		etc = Filter.getFilterWithGroupAndIndex(.Etc,  info[APIKeys.etc].intValue)
		
	}
    
}
