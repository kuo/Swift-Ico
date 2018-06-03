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
import Moya
import PKHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PopViewCallbackProtocol {
    
    let presenter = MainViewPresenter()
    let tableview = UITableView()
    
    var mCurrentPriceModel: CurrentPriceModel?
    var mLatestDaysData: [DayData] = []
    var queryTokenName:String! = "bitcoin"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let moreButton = UIBarButtonItem(image: UIImage(named: "icon_more")?.withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .done, target: self, action: #selector(playTapped))
        self.navigationItem.rightBarButtonItems = [moreButton]
        initTitleBar()
        
        
        self.view.backgroundColor = UIColor.black
        
        tableview.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = 144.0 //自動調整UITableView內cell的高度
        tableview.alwaysBounceVertical = false
        
        self.view.addSubview(tableview)
        
        presenter.attachView(v: self)
        getCurrentPriceByToken(token: queryTokenName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func playTapped()  {
        //navigate(nav: MainNavigator.openMenu())
        let toVC = TokenTableVC()
        toVC.callBack = self
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    //delegate: 選擇查詢貨幣種類
    func chooseTokenComplete(vc: UIViewController, token: String) {
        self.navigationController?.popToViewController(self, animated: true)
        queryTokenName = token
        initTitleBar()
        getCurrentPriceByToken(token: queryTokenName)
    }
    
    func initTitleBar() {
        setNavigationTitle(title: "報幣(" + queryTokenName + ")" )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.section == 0) {
            let cell = CurrentInfoCell(style: .default, reuseIdentifier: "CurrentInfoCell")
            guard self.mCurrentPriceModel != nil else {return cell}
            
            cell.updateCurrentPriceData(model: self.mCurrentPriceModel)
            return cell
            
        } else if(indexPath.section == 1) {
            let cell = ExchangeCell(style: .default, reuseIdentifier: "ExchangeCell")
            guard self.mCurrentPriceModel != nil else {return cell}
            
            cell.updateExchangeRate(model: self.mCurrentPriceModel, token: queryTokenName)
            return cell
        }
        else if(indexPath.section == 2) {
            if indexPath.row != (self.mLatestDaysData.count) {
                let cell = HistoryCell(style: .default, reuseIdentifier: "HistoryCell")
                if self.mLatestDaysData.count > 0 {
                    cell.updateData(data: self.mLatestDaysData[indexPath.row])
                }
                
                return cell
            } else {
                let cell = MoreInfoCell(style: .default, reuseIdentifier: "MoreInfoCell")
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 120
        } else if indexPath.section == 1 {
            return 180
        } else {
            return UITableViewAutomaticDimension
        }
    }

    
    //此TableView有幾組Section
    func numberOfSections(in tableView: UITableView) -> Int {
        /**
         * Section 1: 即時匯率
         * Section 2: 匯率換算
         * Section 3: 歷史紀錄
         */
        return 3
    }
    
    //個別的Section設定Row的數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if(section == 0) {
            count = 1
        }
        else if(section == 1) {
            count = 1
        }
        else if(section == 2) {
            count = mLatestDaysData.count + 1
        }
        
        return count
    }
    
    //個別Section Header的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0 || section == 1) {
            return 40
        }
        else {
            return 70
        }
    }
    
    //個別Section Header的View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0 || section == 1) {
            let headerBg = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
            headerBg.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_header_bg)
            
            let title = UILabel()
            title.numberOfLines = 0
            title.textColor = UIColor.white
            
            if section == 0 {
                title.text = "即時匯率"
            } else if section == 1 {
                title.text = "匯率換算"
            }
            title.sizeToFit()
            headerBg.addSubview(title)
            
            title.snp.makeConstraints { (make) in
                make.center.equalTo(headerBg)
            }
            
            return headerBg
        }
        else {
            let headerBg = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 70))
            let titleHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
            headerBg.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
            titleHeaderView.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_header_bg)
            headerBg.addSubview(titleHeaderView)
            
            let title = UILabel()
            title.numberOfLines = 0
            title.textColor = UIColor.white
            title.text = "前五個交易日"
            title.sizeToFit()
            titleHeaderView.addSubview(title)
            
            title.snp.makeConstraints { (make) in
                make.center.equalTo(titleHeaderView)
            }
            
            //加入歷史紀錄標題：日期，價格，24hr漲幅
            let dateTag = UILabel()
            dateTag.numberOfLines = 0
            dateTag.textColor = UIColor.white
            dateTag.text = "日期"
            dateTag.sizeToFit()
            headerBg.addSubview(dateTag)
            dateTag.snp.makeConstraints({ (make) in
                //make.top.equalTo(titleHeaderView.snp.bottom).offset(5)
                make.left.equalTo(30)
                make.bottom.equalTo(0)
            })
            
            let priceTag = UILabel()
            priceTag.numberOfLines = 0
            priceTag.textColor = UIColor.white
            priceTag.text = "價格"
            priceTag.sizeToFit()
            headerBg.addSubview(priceTag)
            priceTag.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.centerX.equalTo(titleHeaderView)
            })
            
            let gainTag = UILabel()
            gainTag.numberOfLines = 0
            gainTag.textColor = UIColor.white
            gainTag.text = "24hr漲幅"
            gainTag.sizeToFit()
            headerBg.addSubview(gainTag)
            gainTag.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.right.equalTo(titleHeaderView).offset(-30)
            })
            
            return headerBg
            
        }
        
        
    }
    
    //tableView row點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row >= self.mLatestDaysData.count {
                navigate(nav: MainNavigator.moreInfoAboutToken(token: self.queryTokenName))
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 40
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
    func getCurrentPriceByToken(token:String!) {
        startLoadingView()
        presenter.getCurrentPrice(token: token)
    }
    
    func getLatestDaysDataByToken(token:String!) {
        mLatestDaysData.removeAll()
        presenter.getLastDaysExchangeData(token:token)
    }
    
    func updateUI() {
        tableview.reloadData()
    }
}


extension ViewController: MainViewProtocol {
    
    func onReceiveCurrentPrice(price: CurrentPriceModel) {
        self.mCurrentPriceModel = price
        getLatestDaysDataByToken(token: queryTokenName)
    }
    
    func onReceiceLatestDaysData(dataList: [DayData]) {
        dismissLoadingView()
        self.mLatestDaysData = dataList
        updateUI()
    }
}

