//
//  BasePresenter.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/10.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import Moya

class BasePresenter: NSObject {
    var view : BaseViewProtocol?
    let apiProvider = MoyaProvider<WebApiService>(plugins: [MyNetworkLogPlugin(verbose: true)])
    
    func attachView(v: BaseViewProtocol) {
        self.view = v
    }
    
    func detachView() {
        self.view = nil
    }
}
