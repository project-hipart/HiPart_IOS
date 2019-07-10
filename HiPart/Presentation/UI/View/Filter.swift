
import Foundation

enum FilterGroup{
	case BroadcastConcept
	case PD
	case Language
	case Etc
}

enum Filter : String{
	
	case GAME = "게임"
	case ASMR = "ASMR"
	case PRANK = "Prank"
	case SPORT = "스포츠"
	case MUKBANG = "쿡/먹방"
	case MOVIE_MUSIC = "영화/음악"
	case EDU_INFO = "교육/정보"
	
	case EDIT = "편집"
	case PLAN="기획"
	
	case ENGLISH = "영어"
	case JAPANESE = "일본어"
	case CHINESE = "중국어"
	case GERMAN = "독일어"
	case INDIAN = "인도어"
	case RUSSIAN = "러시아어"
	case INDONESIAN = "인도네시아어"
	case VIETNANESE = "베트남어"
	case ITALIAN = "이탈리아어"
	case FRENCH = "프랑스어"
	case SPANISH = "스페인어"
	
	case EQUIP = "소품"
	case CODI = "코디"
	case LIGHT = "조명"
	case CAMERA = "촬영"
	case MANAGE = "매니저"
	case THUMBNAIL = "썸네일"
	
	var intValue : Int{
		switch self{
			
		case .GAME: return 1
		case .ASMR: return 2
		case .PRANK: return 3
		case .SPORT: return 4
		case .MUKBANG: return 5
		case .MOVIE_MUSIC: return 6
		case .EDU_INFO: return 7
	
		case .EDIT: return 1
		case .PLAN: return 2
			
		case .ENGLISH: return 1
		case .JAPANESE: return 2
		case .CHINESE: return 3
		case .GERMAN: return 4
		case .INDIAN: return 5
		case .RUSSIAN: return 6
		case .INDONESIAN: return 7
		case .VIETNANESE: return 8
		case .ITALIAN: return 9
		case .FRENCH: return 10
		case .SPANISH: return 11
			
		case .EQUIP: return 1
		case .CODI: return 2
		case .LIGHT: return 3
		case .CAMERA: return 4
		case .MANAGE: return 5
		case .THUMBNAIL: return 6
			
		}
	}
	static func getFilterWithGroupAndIndex(_ group : FilterGroup, _ index : Int) -> Filter?{
		switch group{
		case .BroadcastConcept:
			return getAllBroadcastFilters().first(where: {return $0.intValue == index})
		case .PD:
			return getAllPdFilters().first(where: {return $0.intValue == index})
		case .Language:
			return getAllLanguageFilters().first(where: {return $0.intValue == index})
		case .Etc:
			return getAllEtcFilters().first(where: {return $0.intValue == index})
		}
	}
	
	static func getAllFilters() -> [Filter]{
		return [
			GAME,ASMR,PRANK,SPORT,MUKBANG,MOVIE_MUSIC,EDU_INFO,
			EDIT,PLAN,
			ENGLISH,JAPANESE,CHINESE,GERMAN,INDIAN,RUSSIAN,INDONESIAN,VIETNANESE,ITALIAN,FRENCH,SPANISH,
			EQUIP,CODI,LIGHT,CAMERA,MANAGE,THUMBNAIL
		]
	}
	static func getAllBroadcastFilters() -> [Filter]{
		return getAllFilters().filter{ filter in
			return filter.filterGroup == FilterGroup.BroadcastConcept
		}
	}
	static func getAllPdFilters() -> [Filter]{
		return getAllFilters().filter{ filter in
			return filter.filterGroup == FilterGroup.PD
		}
	}
	static func getAllLanguageFilters() -> [Filter]{
		return getAllFilters().filter{ filter in
			return filter.filterGroup == FilterGroup.Language
		}
	}
	static func getAllEtcFilters() -> [Filter]{
		return getAllFilters().filter{ filter in
			return filter.filterGroup == FilterGroup.Etc
		}
	}
	
	static func sortWithUserType( _ filters : inout [Filter], type : UserType){
		switch type{
		case .Creator:
			if let filter = filters.first(where: {filter in
				return filter.filterGroup == .BroadcastConcept
			}){
				let index = filters.firstIndex(of: filter)!
				filters.swapAt(0, index)
			}
		case .PD:
			if let filter = filters.first(where: {filter in
				return filter.filterGroup == .PD
			}){
				let index = filters.firstIndex(of: filter)!
				filters.swapAt(0, index)
			}
		case .Translator:
			if let filter = filters.first(where: {filter in
				return filter.filterGroup == .Language
			}){
				let index = filters.firstIndex(of: filter)!
				filters.swapAt(0, index)
			}
		case .Etc:
			if let filter = filters.first(where: {filter in
				return filter.filterGroup == .Etc
			}){
				let index = filters.firstIndex(of: filter)!
				filters.swapAt(0, index)
			}
		default:
			break
		}
	}
	
	var filterGroup : FilterGroup{
		switch self{
		case .GAME,.ASMR,.PRANK,.SPORT,.MUKBANG,.MOVIE_MUSIC,.EDU_INFO:
			return FilterGroup.BroadcastConcept
		
		case .EDIT,.PLAN:
			return FilterGroup.PD
			
		case .ENGLISH,.JAPANESE,.CHINESE,.GERMAN,.INDIAN,.RUSSIAN,.INDONESIAN,.VIETNANESE,.ITALIAN,.FRENCH,
			 .SPANISH:
			return FilterGroup.Language
			
		case .EQUIP,.CODI,.LIGHT,.CAMERA,.MANAGE,.THUMBNAIL:
			return FilterGroup.Etc
			
		}
	}
}
