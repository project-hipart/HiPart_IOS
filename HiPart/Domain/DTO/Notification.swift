// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let notification = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import SwiftyJSON

// MARK: - Welcome
struct Notification: Codable {
	let type: Int
	let content : String
	let createdAt: String
	
	init(fromJson json : JSON) {
		self = try! JSONDecoder.init().decode(Notification.self, from: try! json.rawData())
	}
}
