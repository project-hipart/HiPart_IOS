import Foundation

struct UploadVideo{
<<<<<<< HEAD
=======
	var workIndex : Int
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	var thumbnail : String
	var url : String
	var title : String
	var content : String
	
<<<<<<< HEAD
	static func getArrayWithDatas(thumbnails : [String], urls : [String], titles : [String] , contents : [String] ) -> [UploadVideo]{
		var result : [UploadVideo] = []
		for i in 0..<thumbnails.count{
			let uploadVideo = UploadVideo(thumbnail: thumbnails[i], url: urls[i], title: titles[i], content: contents[i])
=======
	static func getArrayWithDatas(workIndexes : [Int],thumbnails : [String], urls : [String], titles : [String] , contents : [String] ) -> [UploadVideo]{
		var result : [UploadVideo] = []
		for i in 0..<thumbnails.count{
			let uploadVideo = UploadVideo(workIndex : workIndexes[i],thumbnail: thumbnails[i], url: urls[i], title: titles[i], content: contents[i])
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			result.append(uploadVideo)
		}
		return result
	}
}
