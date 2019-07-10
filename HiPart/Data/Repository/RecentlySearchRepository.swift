
import Foundation

class RecentlySearchRepository{
	public static let shared = RecentlySearchRepository()
	private init(){}
	
	func getRecentlySearchKeyword() -> [String]{
		return (UDUtil.object(forKey: .recentlySearchKeyword) as? [String]) ?? []
	}
	func saveRecentlySearchKeyword(keyword : String){
		var current = getRecentlySearchKeyword()
		current.insert(keyword, at: 0)
		if current.count > 20{
			current = current.dropLast()
		}
		UDUtil.set(current, forKey: .recentlySearchKeyword)
	}
	func saveRecentlySearchKeyword(keywords : [String]){
		UDUtil.set(keywords, forKey: .recentlySearchKeyword)
	}
}
