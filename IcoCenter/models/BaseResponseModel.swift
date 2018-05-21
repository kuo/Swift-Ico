//
//  BaseResponseModel.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/11.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponseModel: Mappable {
    
    var msg:String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        msg <- map["msg"]
    }
    
    
}
