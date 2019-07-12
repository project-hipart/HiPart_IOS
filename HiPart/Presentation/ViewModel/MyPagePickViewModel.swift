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

class MyPagePickViewModel {
    
    weak var delegate : MyPagePickViewModelDelegate? = nil{
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
            delegate?.onChangeProfiles(profiles: self.profiles)
        }
    }
    
    
    init() {loadDatas()}
    
    func loadDatas(){
        isRefreshing = true
        
        PickRepository.shared.pickGet{profiles in
            
            if let profiles = profiles{
                self.profiles = profiles
            }else{
                debugE("에러")
            }
            self.isRefreshing = false
        }
        
    }
    
}
protocol MyPagePickViewModelDelegate : NSObjectProtocol{
    func onChangeProfiles(profiles : [ProfileDTO])
    func onChangeRefreshState(isRefreshing : Bool)
}
