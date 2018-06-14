//
//  ChartVC.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/19.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit
import SwiftChart
import RxSwift
import RxCocoa

class ChartVC: UIViewController, ChartDelegate {
    
    var mTokenName:String
    var valueLabel = UILabel()
    let presenter = ChartViewPresenter()
    let chart = Chart()
    let scope = UILabel()
    var disposeBag = DisposeBag()
    
    init(tokenName:String) {
        self.mTokenName = tokenName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle(title: "線圖")
        setNavigationBackButton(title: "返回")
        
        initTopBtn()
        
        //折線圖
        chart.delegate = self
        chart.labelFont = UIFont.systemFont(ofSize: 10)
        chart.gridColor = UIColor.white
        chart.axesColor = UIColor.white
        chart.labelColor = UIColor.white
        self.view.addSubview(chart)
        
        chart.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(self.view)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
        }
        
        //scope value
        scope.textColor = UIColor.white
        scope.sizeToFit()
        self.view.addSubview(scope)
        scope.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(chart.snp.bottom).offset(25)
        }
        
        presenter.attachView(v: self)
        startLoadingView()
        presenter.getDurationData(token: self.mTokenName, type: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTopBtn() {
        let choiceBtn = UIButton()
        choiceBtn.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_5)
        choiceBtn.setTitleColor(UIColor(hexString:GlobalDefine.GPColors.kColor_theme_white_50), for: .normal)
        choiceBtn.setTitle("近1週", for: .normal)
        choiceBtn.contentHorizontalAlignment = .left
        choiceBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.view.addSubview(choiceBtn)
        choiceBtn.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(self.view)
            make.height.equalTo(36)
            make.top.equalToSuperview().offset(90)
            make.right.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(25)
        }
        
        choiceBtn.rx.tap.bind(onNext: { () in
            
            let queryDuration = ["Cancel", "近一週", "近一個月"]
            self.present(GPAlertController.actionSheet(title: "", msg: "區間", buttons: queryDuration, tapBlock: { (action, index) -> Void in
                
                print("index = \(index)")
                let queryType = index
                if queryType != 0 {
                    self.startLoadingView()
                    self.presenter.getDurationData(token: self.mTokenName, type: queryType)
                }
                
                
            }), animated: true, completion: nil)
            
        }).disposed(by: disposeBag)
        
    }
    
    /**
     * Chart touch delegate
     */
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.minimumIntegerDigits = 1
            valueLabel.text = numberFormatter.string(from: NSNumber(value: value))
            
            valueLabel.snp.remakeConstraints({ (make) in
                make.left.equalToSuperview().offset(left)
                make.bottom.equalTo(chart.snp.top).offset(-8)
            })
            self.view.layoutIfNeeded()
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    func drawChartView(mList:[DurationDayData]) {

        var data = [(x: 0, y: 0 as Double)]
        var label = [Double]()
        var labelsAsString: Array<String> = []
        data[0] = (x:0, y:mList[0].price_usd)
        
        for (index, element) in mList.enumerated() {
            if index != 0 {
                data.append((x: index, y: element.price_usd))
            }
            
            if mList.count >= 10 {
                if(index % 5 == 0) {
                    label.append(Double(index))
                    labelsAsString.append(mList[index].date)
                }
            } else {
                label.append(Double(index))
                labelsAsString.append(mList[index].date)
            }
            
        }
        
        let series = ChartSeries(data: data)
        chart.removeAllSeries()
        chart.add(series)
        chart.xLabels = label
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        
        valueLabel.numberOfLines = 0
        valueLabel.textColor = UIColor.white
        valueLabel.text = ""
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont.systemFont(ofSize: 12)
        valueLabel.sizeToFit()
        self.view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(chart.snp.top).offset(-8)
        }
    }
    
    func updateScopeValue(max:Float, min:Float) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        scope.text = "範圍： " + numberFormatter.string(from: NSNumber(value: min))! + " ~ " + numberFormatter.string(from: NSNumber(value: max))!
    }
}

extension ChartVC: ChartViewProtocol {
    func onReceiveDurationData(m: DurationDataModel) {
        let sortedList = m.mList?.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
        drawChartView(mList: sortedList!)
        updateScopeValue(max: m.duration_max, min: m.duration_min)
        dismissLoadingView()
    }
    
}
