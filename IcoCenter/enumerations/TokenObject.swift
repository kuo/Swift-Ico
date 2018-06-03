//
//  TokenObject.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/18.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation

enum TokenObject:String {
    case btc = "bitcoin"
    case eth = "ethereum"
    case btccash = "bitcoin-cash"
    case ltc = "litecoin"
    case mith = "mithril"
    
    func getObject() -> GlobalDefine.TokenStruct{
        switch self {
        case .btc:
            return GlobalDefine.TokenStruct(tokenName: self.rawValue, icon: "bitcoin", displayName: "比特幣")
        case .eth:
            return GlobalDefine.TokenStruct(tokenName: self.rawValue, icon: "ethereum", displayName: "以太幣")
        case .btccash:
            return GlobalDefine.TokenStruct(tokenName: self.rawValue, icon: "bitcoin_cash", displayName: "比特現金")
        case .ltc:
            return GlobalDefine.TokenStruct(tokenName: self.rawValue, icon: "icon_litecoin", displayName: "萊特幣")
        case .mith:
            return GlobalDefine.TokenStruct(tokenName: self.rawValue, icon: "mithril", displayName: "秘銀幣")
        }
        
    }
    
    var description : String {
        switch self {
            case .btc: return "BTC"
            case .eth: return "ETH"
            case .btccash: return "BCH"
            case .ltc: return "LTC"
            case .mith: return "MITH"
        }
    }
    
}
