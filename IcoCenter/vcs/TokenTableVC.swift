//
//  TokenTableVC.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/16.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit


class TokenTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableview = UITableView()
    let tokenArray = ["bitcoin", "ethereum", "bitcoin-cash", "litecoin", "mithril"]
    var callBack : PopViewCallbackProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle(title: "選擇幣別")
        setNavigationBackButton(title: "返回")
        
        tableview.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = 144.0 //自動調整UITableView內cell的高度
        tableview.alwaysBounceVertical = false
        tableview.backgroundColor = UIColor.black
        
        self.view.addSubview(tableview)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tokenArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChooseTokenCell(style: .default, reuseIdentifier: "ChooseTokenCell")
        let t = TokenObject(rawValue: tokenArray[indexPath.row])
        cell.updateData(name: (t?.getObject().tokenDisplayName)!, icon: (t?.getObject().tokenIcon)!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click name = \(tokenArray[indexPath.row])")
        
        if let delegate = self.callBack {
            delegate.chooseTokenComplete(vc: self, token: tokenArray[indexPath.row])
        }
    }
}
