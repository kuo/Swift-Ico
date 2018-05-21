//
//  WebApiService.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/10.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import Moya

public enum WebApiService {
    case CurrentPrice(tokenName:String)             //取得現在價格
    case LaseFiveDaysExchangeData(tokenName:String) //最近五個交易日
}

extension WebApiService: TargetType {
    
    
    public var task: Task {
        switch self {
        case .CurrentPrice(_):
            return .requestPlain
        case .LaseFiveDaysExchangeData(_):
            return .requestPlain
        }
    }
    
    public var baseURL: URL {
        let myBaseUrl  = GlobalDefine.ApiBaseUrl.BaseUrl
        return URL(string: myBaseUrl!)!
    }
    
    public var path: String {
        switch self {
        case .CurrentPrice(let token):
            return "tokenId/\(token)"
        case .LaseFiveDaysExchangeData(let token):
            return "last/\(token)"
        }
        
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        let apiHeader: [String: String] = [:]
        return apiHeader
    }
}
