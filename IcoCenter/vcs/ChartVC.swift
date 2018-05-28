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

class ChartVC: UIViewController, ChartDelegate {
    
    var mTokenName:String
    var valueLabel = UILabel()
    let presenter = ChartViewPresenter()
    let chart = Chart()
    let scope = UILabel()
    
    init(tokenName:String) {
        self.mTokenName = tokenName
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let choiceBtn = UIButton()
        choiceBtn.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_4)
        choiceBtn.setTitleColor(UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange), for: .normal)
        choiceBtn.setTitle("近1週", for: .normal)
        choiceBtn.contentHorizontalAlignment = .left
        choiceBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.view.addSubview(choiceBtn)
        choiceBtn.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(self.view)
            make.height.equalTo(36)
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(25)
        }
        
        //折線圖
        chart.delegate = self
        chart.labelFont = UIFont.systemFont(ofSize: 10)
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
        let text = UILabel()
        text.text = "範圍"
        text.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
        text.sizeToFit()
        self.view.addSubview(text)
        text.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(chart.snp.bottom).offset(25)
        }
        
        scope.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
        scope.sizeToFit()
        self.view.addSubview(scope)
        scope.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(text.snp.bottom).offset(2)
        }
        
        presenter.attachView(v: self)
        presenter.getDurationData(token: "bitcoin", type: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Chart touch delegate
     */
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
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
            
            label.append(Double(index))
            labelsAsString.append(mList[index].date)
        }
        
        let series = ChartSeries(data: data)
        chart.add(series)
        chart.xLabels = label
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        
        valueLabel.numberOfLines = 0
        valueLabel.textColor = UIColor.black
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
        scope.text = numberFormatter.string(from: NSNumber(value: min))! + " ~ " + numberFormatter.string(from: NSNumber(value: max))!
    }
}

extension ChartVC: ChartViewProtocol {
    func onReceiveDurationData(m: DurationDataModel) {
        let sortedList = m.mList?.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
        drawChartView(mList: sortedList!)
        updateScopeValue(max: m.duration_max, min: m.duration_min)
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    
}
