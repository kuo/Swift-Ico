//
//  MainNavigator.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/16.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

public enum MainNavigator:Navigation {
    case openMenu()
    case moreInfoAboutToken(token:String)
}

struct AppNavigator:AppNavigation {
    func viewControllerForNavigation(nav: Navigation) -> UIViewController {
        if let navigation = nav as? MainNavigator {
            switch navigation {
            case .openMenu():
                return TokenTableVC()
            case .moreInfoAboutToken(let t):
                return ChartVC(tokenName: t)
            }
        }
        return UIViewController()
    }
    
    func navigate(nav: Navigation, fromVC: UIViewController, toVC: UIViewController) {
        
        fromVC.navigationController?.pushViewController(toVC, animated: true)
        
        toVC.view.backgroundColor = UIColor.black
        toVC.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = "返回"
        toVC.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
