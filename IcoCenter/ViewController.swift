//
//  ViewController.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/3.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import UIKit
import SnapKit
import DynamicColor

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var strarr:[String] = ["某年某月某日在宇宙的某个角落，张根生近一个月第一次走出房间。他的头发蓬松散","张根生一只脚伸到街道的阳光下，而后又缩了回来。一个大妈提着一篮子菜从他身边走过侧脸看了他一下，张根生躲闪着目光企图让自己躲避起来，不要让人注意到他。可是这样做却起到了反效果，每个路过的人","张根生犹豫了再三，鼓起勇气走上街道。他缩着头，大衣把他整个人都掩着严严实实。他的步伐快速。大衣把两边的视野挡住了，他又不敢抬头，只看到行人的腿脚无法十分准确判断他们位置，所以他不可避免地与好几个人相撞了。他恐惧在人群中，仿佛自己就是落入狼群的羊，觉得自己无法呼吸也没法思考，脑子里一直有个声音在呐喊：逃快点，再快点。他的步伐越来越来。撞到人了，他也没有停下来跟人家说"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "報幣"
        
        let tableview = UITableView()
        tableview.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = 144.0 //自動調整UITableView內cell的高度
        //tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(tableview)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = HistoryCell(style: .default, reuseIdentifier: "OneCell")
        //var cell:UITableViewCell? = nil
        if(indexPath.section == 0) {
            let cell = CurrentInfoCell(style: .default, reuseIdentifier: "CurrentInfoCell")
            //cell.oneLabel.text = "test"
            return cell
        } else if(indexPath.section == 1) {
            let cell = HistoryCell(style: .default, reuseIdentifier: "OneCell")
            cell.oneLabel.text = strarr[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 150
        } else {
            return UITableViewAutomaticDimension
        }
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
        return 40
    }
    
    //個別Section Header的View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerBg = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        headerBg.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_header_bg)
        
        let title = UILabel()
        title.numberOfLines = 0
        title.textColor = UIColor.white
        if section == 0 {
            title.text = "即時匯率"
        } else if section == 1 {
            title.text = "前五個交易日"
        }
        
        title.sizeToFit()
        headerBg.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.center.equalTo(headerBg)
        }
        
        return headerBg
        
    }
    
    
    
}

