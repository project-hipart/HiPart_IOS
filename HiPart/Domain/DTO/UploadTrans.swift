import Foundation

struct UploadTrans{
	var workIndex : Int
	var before : String
	var after : String
	
	static func getArrayWithDatas(workIndexes : [Int],befores : [String], afters : [String]) -> [UploadTrans]{
		var result : [UploadTrans] = []
		for i in 0..<workIndexes.count{
			let item = UploadTrans(workIndex: workIndexes[i], before: befores[i], after: afters[i])
			result.append(item)
		}
		return result
	}
}
