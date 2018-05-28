//
//  ChartViewPresenter.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/24.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class ChartViewPresenter: BasePresenter {
    
    func getDurationData(token:String, type:Int) {
        apiProvider.request(WebApiService.ChartData(tokenName: token, queryType: type)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let res = Mapper<DurationDataModel>().map(JSONString: json.description)
        
                guard let existRes = res else {return}
                
                if let v = self.view as? ChartViewProtocol {
                    v.onReceiveDurationData(m: existRes)
                }
            }
        }
    }
}
