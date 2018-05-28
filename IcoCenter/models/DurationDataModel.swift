//
//  DurationDataModel.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/26.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import ObjectMapper

class DurationDataModel: BaseResponseModel {
    var mList:[DurationDayData]?
    var duration_max:Float!
    var duration_min:Float!
    
    override func mapping(map: Map) {
        mList <- map["result.dataList"]
        duration_max <- map["result.duration_max"]
        duration_min <- map["result.duration_min"]
    }
}

struct DurationDayData: Mappable {
    
    var date:String!
    var price_usd:Double!
    var percent_change_24h:String!    
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        date <- map["date"]
        price_usd <- map["price_usd"]
        percent_change_24h <- map["percent_change_24h"]
        
        var dateArr = date.components(separatedBy: "-")
        let calendar = NSCalendar.current
        let components = NSDateComponents()
        components.day = Int(dateArr[2])!
        components.month = Int(dateArr[1])!
        components.year = Int(dateArr[0])!
        var newDate = calendar.date(from: components as DateComponents)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        date = dateFormatter.string(from: newDate!)
        print("")
    }
    
}
