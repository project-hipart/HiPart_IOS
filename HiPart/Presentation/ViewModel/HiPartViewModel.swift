//
//  HiPartViewModel.swift
//  HiPart
//
//  Created by 최은희 on 30/06/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//
<<<<<<< HEAD

import Foundation
import RxSwift
=======
import Foundation

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
import Alamofire
import SwiftyJSON

class HiPartViewModel {
<<<<<<< HEAD
	var currentTab : ProfileFlag = .All
	private let disposeBag = DisposeBag()
	
	weak var delegate : HiPartViewModelDelegate? = nil{
		didSet{
			self.delegate?.onChangeProfiles(profiles: profiles)
			self.delegate?.onChangeRefreshState(isRefreshing: isRefreshing)
=======
	
	var currentTab : ProfileFlag = .All
	
	weak var delegate : HiPartViewModelDelegate? = nil{
		didSet{
			
			self.delegate?.onChangeProfiles(profiles: profiles)
			self.delegate?.onChangeRefreshState(isRefreshing: isRefreshing)
			
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		}
	}
	
	var isRefreshing : Bool = false{
		didSet{
			delegate?.onChangeRefreshState(isRefreshing: self.isRefreshing)
		}
	}
	var profiles : [ProfileDTO] = []{
		didSet{
<<<<<<< HEAD
			delegate?.onChangeProfiles(profiles: profiles)
		}
	}
	
	init() {
		loadDatas(.All)
	}
	
	func loadDatas(_ flag : ProfileFlag){
		currentTab = flag
		isRefreshing = true


		MainAPI.requestSearch(keyword: "최은희")
			.subscribe(onSuccess: {
				debugE($0)
			}, onError: {
				debugE($0)
			})
		
		ProfileRepository.shared.list(flag: flag)
			.do(onDispose: {self.isRefreshing = false})
			.subscribe(onSuccess: { profiles in
			self.profiles = profiles
				
				self.isRefreshing = false
			}, onError: {
				debugE($0)
				self.isRefreshing = false
		}).disposed(by: self.disposeBag)
=======
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
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	}
	
}
protocol HiPartViewModelDelegate : NSObjectProtocol{
	func onChangeProfiles(profiles : [ProfileDTO])
	func onChangeRefreshState(isRefreshing : Bool)
}
