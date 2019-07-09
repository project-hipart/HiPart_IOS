import RxSwift
import Foundation


class SearchDetailViewModel{
	
	private let disposeBag = DisposeBag()
	
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
		MainRepository.shared.search(keyword: keyword)
			.subscribe(onSuccess: { profiles in
				self.allProfiles = profiles
				self.profiles = profiles.filter{[unowned self]profile in
					if self.currentUserTypeFilter == .All{
						return true
					}
					return [UserType.All, self.currentUserTypeFilter].contains(profile.type)
				}
			}, onError: { err in
				debugE(err)
			}).disposed(by: disposeBag)
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
