//
//  TokenHelper.swift
//  HiPart
//
//  Created by 최은희 on 07/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation
import Alamofire

typealias Token = String
class TokenHelper{
	static func saveAccessToken(token : Token){
		UDUtil.set(token, forKey: .accessToken)
	}
	static func loadAccessToken() -> Token?{
		return UDUtil.string(forKey: .accessToken)
	}
	static func getCommonHeader() -> HTTPHeaders?{
		let token = loadAccessToken()
		if token == nil{return nil}
		
		return ["token" : token!]
	}
}
