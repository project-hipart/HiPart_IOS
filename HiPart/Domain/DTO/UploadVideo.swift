import Foundation

struct UploadVideo{
	var thumbnail : String
	var url : String
	var title : String
	var content : String
	
	static func getArrayWithDatas(thumbnails : [String], urls : [String], titles : [String] , contents : [String] ) -> [UploadVideo]{
		var result : [UploadVideo] = []
		for i in 0..<thumbnails.count{
			let uploadVideo = UploadVideo(thumbnail: thumbnails[i], url: urls[i], title: titles[i], content: contents[i])
			result.append(uploadVideo)
		}
		return result
	}
}
