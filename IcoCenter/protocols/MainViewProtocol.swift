//
//  MainViewProtocol.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/10.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation

protocol MainViewProtocol:BaseViewProtocol {

    func onReceiveCurrentPrice(price: CurrentPriceModel)
    func onReceiceLatestDaysData(dataList: [DayData])
}
