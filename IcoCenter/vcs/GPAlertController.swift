//
//  GPAlertController.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/6/3.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

class GPAlertController: NSObject {
    private static var mInstance:GPAlertController?
    
    //Singleton
    static func sharedInstance() -> GPAlertController {
        if(mInstance == nil) {
            mInstance = GPAlertController()
        }
        
        return mInstance!
    }
    
    fileprivate func topController() -> UIViewController {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController
        {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("Error: You don't have any views")
        }
        
        return presentedVC!
    }
    
    @discardableResult
    open class func actionSheet(title:String, msg:String, buttons:[String], tapBlock:((UIAlertAction, Int) -> Void)?) -> UIAlertController {
        //呼叫擴充的UIAlertController
        let alert = UIAlertController(alertTitle: title, alertMsg: msg, buttons: buttons, tapBlock: tapBlock)
        
        return alert
    }
}

private extension UIAlertController {
    //Swift 中，Extension只能使用 convenience init
    //block 內傳入action 與 index
    convenience init(alertTitle:String, alertMsg:String, buttons:[String], tapBlock:((UIAlertAction, Int) -> Void)?) {
        self.init(title: alertTitle, message: alertMsg, preferredStyle: .actionSheet)
        var buttonIndex = 0
        
        buttons.forEach { (btn) in
            //呼叫擴充的UIAlertAction
            if buttonIndex == 0 {
                let action = UIAlertAction(title: "Cancel", sheetBtnIndex: buttonIndex, style: UIAlertActionStyle.cancel, tapBlock: tapBlock)
                self.addAction(action)
            }
            else {
                let action = UIAlertAction(title: btn, sheetBtnIndex: buttonIndex, style: UIAlertActionStyle.default, tapBlock: tapBlock)
                self.addAction(action)
            }
            buttonIndex += 1
            
        }
        
        //cancel action
        //        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
        //            print("")
        //        }
        //        self.addAction(cancelAction)
    }
}

private extension UIAlertAction {
    //Swift 中，Extension只能使用 convenience init
    //UIAlertActionStyle:
    //1. default: 一般選項
    //2. destructive: 負面選項，將顯示紅色
    //3. cancel: 取消
    convenience init(title:String!, sheetBtnIndex:Int, style:UIAlertActionStyle, tapBlock:((UIAlertAction, Int) -> Void)?) {
        self.init(title: title, style: style) { (action) in
            
            //if let block = tapBlock
            // =
            // let block = tapblock
            //if block != nil {...
            if let block = tapBlock {
                block(action, sheetBtnIndex)
            }
            
        }
    }
}
