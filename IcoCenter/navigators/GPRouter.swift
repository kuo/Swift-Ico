//
//  GPRouter.swift
//  MySnapKit
//
//  Created by AP2MBP on 2018/2/26.
//  Copyright © 2018年 GASHPOINT. All rights reserved.
//

import Foundation
import UIKit

public class GPRouter {
    public static let router:IsRouter = DefaultRouter()
}

public protocol Navigation {}

public protocol AppNavigation {
    func viewControllerForNavigation(nav: Navigation) -> UIViewController
    func navigate(nav: Navigation, fromVC: UIViewController, toVC: UIViewController)
}

public protocol IsRouter {
    func setAppNavigation(nav: AppNavigation)
    func navigate(nav: Navigation, fromVC:UIViewController)
    func didNavigate(block: @escaping (Navigation) -> Void)
    var appNavigation: AppNavigation? { get }
}

public class DefaultRouter: IsRouter {
    public func didNavigate(block: @escaping (Navigation) -> Void) {
        didNavigateBlocks.append(block)
    }
    
    
    public var appNavigation: AppNavigation?
    var didNavigateBlocks = [((Navigation) -> Void)]()
    
    public func setAppNavigation(nav: AppNavigation) {
        self.appNavigation = nav
    }
    
    public func navigate(nav: Navigation, fromVC: UIViewController) {
        if let toVC = self.appNavigation?.viewControllerForNavigation(nav: nav) {
            self.appNavigation?.navigate(nav: nav, fromVC: fromVC, toVC: toVC)
            
            for b in didNavigateBlocks {
                b(nav)
            }
        }
    }
}

//GPRouter injection helper
public protocol Initialize { init() }
open class RuntimeInjection: NSObject, Initialize {
    public required override init() {
        
    }
}

public func appNavigationByClassStringName(className:String) -> AppNavigation {
    let appNavClass = NSClassFromString(className) as! RuntimeInjection.Type
    let appNav = appNavClass.init()
    
    return appNav as! AppNavigation
}

public extension UIViewController {
    public func navigate(nav: Navigation) {
        GPRouter.router.navigate(nav: nav, fromVC: self)
    }
}

