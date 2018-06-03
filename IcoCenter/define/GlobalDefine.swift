//
//  GlobalDefine.swift
//  IcoCenter
//
//  Created by AP2MBP on 2018/5/4.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation

class GlobalDefine {
    
    struct ApiBaseUrl {
        static let BaseUrl:String! = "https://ico-center-apis.herokuapp.com/"
    }
    
    struct GPColors {
        static let kColor_them_black:String!       = "#000000"
        static let kColor_theme_header_bg:String!  = "#484848"
        static let kColor_theme_gray_4:String!     = "#b3b3b3"
        static let kColor_theme_gray_5:String!     = "#9b9a9c"
        static let kColor_theme_gray_9:String!     = "#212121"
        static let kColor_theme_orange:String!     = "#ff5722"
        
        static let kColor_theme_white_50:String!   = "#f9f8e9"
        
        //static let kColor_theme_orange:String!     = "#ff5722"
    }
    
    struct TokenStruct {
        //貨幣名稱
        var tokenName:String
        //顯示貨幣icon
        var tokenIcon:String
        //顯示的貨幣名稱
        var tokenDisplayName:String
        //簡寫
        
        
        init(tokenName:String, icon:String, displayName:String) {
            self.tokenName = (TokenObject(rawValue: tokenName)?.description)!
            self.tokenIcon = icon
            self.tokenDisplayName = displayName
        }
    }
}
