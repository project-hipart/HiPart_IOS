
import Foundation


class SearchDetailViewModel{
	
	
	var allProfiles : [ProfileDTO] = []
	
	var profiles : [ProfileDTO] = []{
		didSet{
			delegate?.onChangeProfiles(profiles: self.profiles)
		}
	}
	
	var currentUserTypeFilter : UserType = .All
	
	weak var delegate : SearchDetailViewModelDelegate? = nil{
		didSet{
			self.delegate?.onChangeProfiles(profiles: self.profiles)
		}
	}
	
	
	func loadDatas(keyword : String){
		MainRepository.shared.search(keyword: keyword){profiles in
			if let profiles = profiles{
				self.allProfiles = profiles
				self.profiles = profiles.filter{[unowned self]profile in
					if self.currentUserTypeFilter == .All{
						return true
					}
					return [UserType.All, self.currentUserTypeFilter].contains(profile.type)
				}
			}else{
				debugE("error")
			}
		}
	}
	
	func changeTypeFilter(_ type : UserType){
		
		currentUserTypeFilter = type
		
		self.profiles = allProfiles.filter{[unowned self]profile in
			if self.currentUserTypeFilter == .All{
				return true
			}
			return [UserType.All, self.currentUserTypeFilter].contains(profile.type)
		}
	}
}

protocol SearchDetailViewModelDelegate : NSObjectProtocol{
	func onChangeProfiles(profiles : [ProfileDTO])
}
