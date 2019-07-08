import RxSwift
import Foundation


class SearchDetailViewModel{
	
	private let disposeBag = DisposeBag()
	
	var profiles : [ProfileDTO] = []{
		didSet{
			delegate?.onChangeProfiles(profiles: self.profiles)
		}
	}
	
	weak var delegate : SearchDetailViewModelDelegate? = nil{
		didSet{
			self.delegate?.onChangeProfiles(profiles: self.profiles)
		}
	}
	
	
	
	 func loadDatas(keyword : String){
		MainRepository.shared.search(keyword: keyword)
			.subscribe(onSuccess: { profiles in
				self.profiles = profiles
			}, onError: { err in
				debugE(err)
			}).disposed(by: disposeBag)
	}
	
}

protocol SearchDetailViewModelDelegate : NSObjectProtocol{
	func onChangeProfiles(profiles : [ProfileDTO])
}
