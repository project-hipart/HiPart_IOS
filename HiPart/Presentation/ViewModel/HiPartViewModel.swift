//
//  HiPartViewModel.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//
import Foundation
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
			changeProfiles(profiles: self.profiles)
		}
	}
	var filteredProfiles : [ProfileDTO] = []
	
	private func changeProfiles(profiles : [ProfileDTO]){
		
		let filteredProfiles = profiles.filter{profile in
			
			if currentFilter == nil{
				return true
			}else{
				switch currentFilter!.filterGroup{
				case .BroadcastConcept:
					return currentFilter == profile.broadcastConcept
				case .PD:
					return currentFilter == profile.pd
				case .Language:
					return currentFilter == profile.language
				case .Etc:
					return currentFilter == profile.etc
				default:
					return false
				}
			}
			
		}
		
		self.filteredProfiles = filteredProfiles
		delegate?.onChangeProfiles(profiles: filteredProfiles)
	}
	
	///이라면 필터 미적용(모두 검색)
	var currentFilter : Filter? = nil{
		didSet{
			changeProfiles(profiles: self.profiles)
		}
	}
	
	init() {loadDatas(.All)}
	
	func loadDatas(_ flag : ProfileFlag){
		currentTab = flag
		isRefreshing = true
		
		ProfileRepository.shared.list(flag: flag){[unowned self] profiles in
			
			if let profiles = profiles{
				self.profiles = profiles
				self.isRefreshing = false
			}else{
				self.isRefreshing = false
			}
			
		}
	}
	
}
protocol HiPartViewModelDelegate : NSObjectProtocol{
	func onChangeProfiles(profiles : [ProfileDTO])
	func onChangeRefreshState(isRefreshing : Bool)
}
