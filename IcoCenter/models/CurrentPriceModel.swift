//
//  CurrentPriceModel.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/11.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import ObjectMapper

class CurrentPriceModel: BaseResponseModel {
    
    var createTime:String!
    var id:String!
    var name:String!
    var percentChange_1h:String!
    var percentChange_24h:String!
    var priceUsd:String!
    var symbol:String!
    
    override func mapping(map: Map) {
        createTime <- map["createTime"]
        id <- map["id"]
        name <- map["name"]
        percentChange_1h <- map["percent_change_1h"]
        percentChange_24h <- map["percent_change_24h"]
        priceUsd <- map["price_usd"]
        symbol <- map["symbol"]
        msg <- map["msg"]
    }
}
