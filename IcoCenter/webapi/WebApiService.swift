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
    //取得現在價格
    case CurrentPrice(tokenName:String)
    //最近五個交易日
    case LaseFiveDaysExchangeData(tokenName:String)
    //取一段期間內的資料
    case ChartData(tokenName:String, queryType:Int)
}

extension WebApiService: TargetType {
    
    
    public var task: Task {
        switch self {
        case .CurrentPrice(_):
            return .requestPlain
        case .LaseFiveDaysExchangeData(_):
            return .requestPlain
        case .ChartData(_, _):
            return .requestPlain
        }
    }
    
    public var baseURL: URL {
        let myBaseUrl  = GlobalDefine.ApiBaseUrl.BaseUrl
        switch self {
        case .ChartData(let token, let type):
            return URL(string: myBaseUrl! + "chartData/token?id=\(token)&type=\(type)")!
        default:
            return URL(string: myBaseUrl!)!
        }
        
    }
    
    public var path: String {
        switch self {
        case .CurrentPrice(let token):
            return "tokenId/\(token)"
        case .LaseFiveDaysExchangeData(let token):
            return "last/\(token)"
        case .ChartData(_, _):
            return ""
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
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .ChartData(let token, let type):
            //return MyURLEncoding.queryString
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
}

extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
