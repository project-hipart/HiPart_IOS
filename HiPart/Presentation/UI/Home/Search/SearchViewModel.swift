
import Foundation

class SearchViewModel{
	
	weak var delegate : SearchViewModelDelegate? = nil
	
	
	init() {
		
	}
	
}

protocol SearchViewModelDelegate : NSObjectProtocol{
}
