//
//  HiPartViewModel.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class HiPartViewModel {
	
	var currentTab : ProfileFlag = .All
	
	weak var delegate : HiPartViewModelDelegate? = nil{
		didSet{
			
			self.delegate?.onChangeProfiles(profiles: profiles)
			self.delegate?.onChangeRefreshState(isRefreshing: isRefreshing)
			
		}
	}
	
	var isRefreshing : Bool = false{
		didSet{
			delegate?.onChangeRefreshState(isRefreshing: self.isRefreshing)
		}
	}
	var profiles : [ProfileDTO] = []{
		didSet{
			delegate?.onChangeProfiles(profiles: profiles.filter{profile in
				
				if currentFilter == nil{
					return true
				}else{
					switch profile.type{
					case .Creator:
						return currentFilter == profile.broadcastConcept
					case .PD:
						return currentFilter == profile.pd
					case .Translator:
						return currentFilter == profile.language
					case .Etc:
						return currentFilter == profile.etc
					default:
						return true
					}
				}
				
			})
		}
	}
	
	///이라면 필터 미적용(모두 검색)
	var currentFilter : Filter? = nil
	
	init() {loadDatas(.All)}
	
	func loadDatas(_ flag : ProfileFlag){
		currentTab = flag
		isRefreshing = true
		
		ProfileRepository.shared.list(flag: flag)
			.do(onDispose: {self.isRefreshing = false})
			.subscribe(onSuccess: { profiles in
				self.profiles = profiles
				self.isRefreshing = false
			}, onError: {
				debugE($0)
				self.isRefreshing = false
			})
	}
	
}
protocol HiPartViewModelDelegate : NSObjectProtocol{
	func onChangeProfiles(profiles : [ProfileDTO])
	func onChangeRefreshState(isRefreshing : Bool)
}
