
import Foundation

enum FilterGroup{
	case Broadcast
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
	
//	var intValue : Int{
//		switch self{
//		case GAME: return 10
//		}
//	}
	
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
			return filter.filterGroup == FilterGroup.Broadcast
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
	
	var filterGroup : FilterGroup{
		switch self{
		case .GAME,.ASMR,.PRANK,.SPORT,.MUKBANG,.MOVIE_MUSIC,.EDU_INFO:
			return FilterGroup.Broadcast
		
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
