//
//  MainViewPresenter.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/11.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class MainViewPresenter: BasePresenter {

    func getCurrentPrice(token:String!) {
        //view?.startLoading()
        apiProvider.request(WebApiService.CurrentPrice(tokenName: "bitcoin")) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let res = Mapper<CurrentPriceModel>().map(JSONString: json.description)
                
                guard let existRes = res else {return}
                
                if let v = self.view as? MainViewProtocol {
                    v.onReceiveCurrentPrice(price: existRes)
                }
            }
        }
    }
    
    func getLastDaysExchangeData(token:String!) {
        apiProvider.request(WebApiService.LaseFiveDaysExchangeData(tokenName: "bitcoin")) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let res = Mapper<DayExchangeDataModel>().map(JSONString: json.description)
     
                guard let existRes = res else {return}

                if let v = self.view as? MainViewProtocol {
                    v.onReceiceLatestDaysData(dataList: existRes.mList!)
                }
            }
        }
    }
}
