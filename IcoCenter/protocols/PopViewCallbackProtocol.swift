//
//  PopViewCallbackProtocol.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/19.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PopViewCallbackProtocol: NSObjectProtocol {
    func chooseTokenComplete(vc: UIViewController, token: String!)
}
