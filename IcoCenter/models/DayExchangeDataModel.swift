//
//  DayExchangeDataModel.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/13.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import ObjectMapper

class DayExchangeDataModel: BaseResponseModel {
    
    var mList:[DayData]?
    
    override func mapping(map: Map) {
        mList <- map["dataList"]
        msg <- map["msg"]
    }
}

struct DayData: Mappable {
    
    var date:String!
    var price_usd:Float!
    var percent_change_24h:String!
    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        date <- map["date"]
        price_usd <- map["price_usd"]
        percent_change_24h <- map["percent_change_24h"]
    }
}
