import Foundation

struct UploadVideo{
	var workIndex : Int
	var thumbnail : String
	var url : String
	var title : String
	var content : String
	
	static func getArrayWithDatas(workIndexes : [Int],thumbnails : [String], urls : [String], titles : [String] , contents : [String] ) -> [UploadVideo]{
		var result : [UploadVideo] = []
		for i in 0..<thumbnails.count{
			let uploadVideo = UploadVideo(workIndex : workIndexes[i],thumbnail: thumbnails[i], url: urls[i], title: titles[i], content: contents[i])
			result.append(uploadVideo)
		}
		return result
	}
}
