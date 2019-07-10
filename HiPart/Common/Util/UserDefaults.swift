import Foundation

class UDUtil {
	enum Keys : String{
		case accessToken = "KEY_ACCESS_TOKEN"
<<<<<<< HEAD
=======
		case recentlySearchKeyword = "RECENTLY_SEARCH_EKDKWADADASKDASD"
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	}
	
	static public func set(_ value:Any?, forKey: Keys){
		UserDefaults.standard.set(value, forKey: forKey.rawValue)
	}
	
	static public func integer(forKey: Keys) -> Int {
		return UserDefaults.standard.integer(forKey: forKey.rawValue)
	}
	
	static public func bool(forKey: Keys) -> Bool {
		return UserDefaults.standard.bool(forKey: forKey.rawValue)
	}
	static public func bool(forKey: String) -> Bool{
		return UserDefaults.standard.bool(forKey: forKey)
	}
	
	static public func float(forKey: Keys) -> Float {
		return UserDefaults.standard.float(forKey: forKey.rawValue)
	}
	
	
	static public func string(forKey: Keys) -> String? {
		return UserDefaults.standard.string(forKey: forKey.rawValue)
	}
	static public func string(forKey : String) -> String?{
		return UserDefaults.standard.string(forKey : forKey)
	}
	
	static public func removeObject(forKey : Keys){
		UserDefaults.standard.removeObject(forKey: forKey.rawValue)
	}
	static public func object(forKey : String) -> Any?{
		return UserDefaults.standard.object(forKey: forKey)
	}
	static public func object(forKey : Keys) -> Any?{
		return UserDefaults.standard.object(forKey : forKey.rawValue)
	}
	
}
