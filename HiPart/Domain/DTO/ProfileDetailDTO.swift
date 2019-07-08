// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import SwiftyJSON


// MARK: - ResCreData
struct ProfileDetailDTO {
	let hifiveState: Int
	let userNickname: String
	let userImg: String
	let userType : UserType
	let detailPlatform: Platform
	let detailSubscriber, detailOneline, detailAppeal, detailWant: String
	let hifive : Int
	let thumbnail: [String]
	let url, title, content: [String]
	let pick: Int
	let etc, concept, lang, pd: Filter?
	
	
	init(fromJSON : JSON){
		hifiveState = fromJSON[APIKeys.hifiveState].intValue
		
		let data = fromJSON["resCreData"]
		
		userNickname = data[APIKeys.userNickname].stringValue
		userImg = data[APIKeys.userImage].stringValue
		userType = UserType(rawValue : data[APIKeys.userType].intValue)!
		detailPlatform = Platform(rawValue : data[APIKeys.detailFlatform].intValue)!
		detailSubscriber = data[APIKeys.detailSubscriber].stringValue
		detailOneline = data[APIKeys.detailOneLine].stringValue
		detailAppeal = data[APIKeys.detailAppeal].stringValue
		detailWant = data[APIKeys.detailWant].stringValue
		
		
		thumbnail = data[APIKeys.thumbnail].arrayObject as? [String] ?? []
		url = data[APIKeys.url].arrayObject as? [String] ?? []
		title = data[APIKeys.title].arrayObject as? [String] ?? []
		content = data[APIKeys.content].arrayObject as? [String] ?? []
		pick = data[APIKeys.pick].intValue
		
		concept = Filter.getFilterWithGroupAndIndex(.BroadcastConcept, data[APIKeys.concept].intValue)
		pd = Filter.getFilterWithGroupAndIndex(.PD, data[APIKeys.pd].intValue)
		lang = Filter.getFilterWithGroupAndIndex(.Language, data[APIKeys.lang].intValue)
		etc = Filter.getFilterWithGroupAndIndex(.Etc, data[APIKeys.etc].intValue)

		hifive = data[APIKeys.hifive].intValue
	}
}
