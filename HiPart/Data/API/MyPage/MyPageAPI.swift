//
//  MyPageAPI.swift
//  HiPart
//
//  Created by 최은희 on 12/07/2019.
//  Copyright © 2019 HiPart. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum MyPageAPI : APIConfiguration {
    case question(comment : String)
    case myPageView
    case myInfoView
    case myPageModify(img: Data, imgUrl: String, type: Int, nickname: String, number: String, password: String, passwordCheck: String)
    case confirmPick
    case confirmNumber
    
    var method: HTTPMethod {
        switch self {
        case .myPageView, .myInfoView, .confirmPick, .confirmNumber:
            return .get
        case .question:
            return .post
        case .myPageModify:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .question:
            return "/mypage/question"
        case .myPageView:
            return "/mypage/info"
        case .myInfoView, .myPageModify:
            return "/mypage/modify"
        case .confirmPick:
            return "/mypage/pick"
        case .confirmNumber:
            return "/mypage/hifive"
        }
    }
    
    var parameters: Parameters? {
        switch self{
        case .question(let comment):
            return ["comment":comment]
        case .myPageModify(let img, let imgUrl, let type, let nickname, let number, let passowrd, let passwordCheck):
            return [APIKeys.userImage:img,APIKeys.imageUrl : imgUrl, APIKeys.userType: type, APIKeys.userNickname: nickname, APIKeys.userNumber: number, APIKeys.password: passowrd, APIKeys.passwordCheck: passwordCheck]
        default:
            return nil
        }
    }
    
    var contentType: ContentType {
        switch self {
        case .myPageModify:
            return ContentType.multipart
        default:
            return ContentType.json
        }
    }
    
    static func requestQuestion(comment: String, completion: @escaping ((JSON?)-> Void)) {
        return APIClient.request(api: MyPageAPI.question(comment: comment), completion: completion)
    }
    
    static func requestMyPageView(completion : @escaping ((JSON?) -> Void)) {
        return APIClient.request(api: MyPageAPI.myPageView, completion: completion)
    }
    
    static func requestMyInfoView(completion : @escaping ((JSON?) -> Void)) {
        return APIClient.request(api: MyPageAPI.myInfoView, completion: completion)
    }
    
    static func requestMyPageModify(img: Data, imgUrl: String, type: Int, nickname: String, number: String, password: String, passwordCheck: String, completion: @escaping ((JSON?) -> Void)) {
        return APIClient.request(api: MyPageAPI.myPageModify(img: img, imgUrl: imgUrl, type: type, nickname: nickname, number: number, password: password, passwordCheck:passwordCheck), completion: completion)
    }
    
    static func requestConfirmPick(completion : @escaping ((JSON?) -> Void)) {
        return APIClient.request(api: MyPageAPI.confirmPick, completion: completion)
    }
    
    static func requestConfirmNumber(completion : @escaping ((JSON?) -> Void)) {
        return APIClient.request(api: MyPageAPI.confirmNumber, completion: completion)
    }
}
