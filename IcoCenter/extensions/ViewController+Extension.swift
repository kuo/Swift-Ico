//
//  ViewController+Extension.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/19.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

extension UIViewController {
    
    func setNavigationBackButton(title:String) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setNavigationTitle(title:String) {
        self.navigationItem.title = title
    }
    
    func startLoadingView() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    func dismissLoadingView() {
        PKHUD.sharedHUD.hide()
    }
}
