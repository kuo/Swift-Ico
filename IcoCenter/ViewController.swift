//
//  ViewController.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/3.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var strarr:[String] = ["某年某月某日在宇宙的某个角落，张根生近一个月第一次走出房间。他的头发蓬松散","张根生一只脚伸到街道的阳光下，而后又缩了回来。一个大妈提着一篮子菜从他身边走过侧脸看了他一下，张根生躲闪着目光企图让自己躲避起来，不要让人注意到他。可是这样做却起到了反效果，每个路过的人","张根生犹豫了再三，鼓起勇气走上街道。他缩着头，大衣把他整个人都掩着严严实实。他的步伐快速。大衣把两边的视野挡住了，他又不敢抬头，只看到行人的腿脚无法十分准确判断他们位置，所以他不可避免地与好几个人相撞了。他恐惧在人群中，仿佛自己就是落入狼群的羊，觉得自己无法呼吸也没法思考，脑子里一直有个声音在呐喊：逃快点，再快点。他的步伐越来越来。撞到人了，他也没有停下来跟人家说"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tableview = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .grouped)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 44.0 //自動調整UITableView內cell的高度
        self.view.addSubview(tableview)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryCell(style: .default, reuseIdentifier: "OneCell")
        if(indexPath.section == 0) {
            cell.oneLabel.text = "test"
        } else if(indexPath.section == 1) {
            cell.oneLabel.text = strarr[indexPath.row]
        }
        
        return cell
    }
    
    //此TableView有幾組Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //個別的Section設定Row的數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if(section == 0) {
            count = 1
        } else if(section == 1) {
            count = strarr.count
        }
        
        return count
    }
    
    //個別Section Header的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    
    
}
