//
//  ExchangeCell.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/9.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ExchangeCell: UITableViewCell, UITextFieldDelegate {
    
    var editTokenValue = UITextField()
    var editUsdValue = UITextField()
    var usdExchangeRate:Double = 0
    
    let disposeBag = DisposeBag()
    let tokenName = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initView()
        initTextFieldObserve()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == self.editTokenValue) {
            if range.location >= 10 {
                return false
            } else {
                return true
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func updateExchangeRate(model:CurrentPriceModel?, token:String!) {
        guard let data = model else {return}
        
        self.usdExchangeRate = Double(data.priceUsd)!
        
        editTokenValue.text = "1"
        editUsdValue.text = data.priceUsd
        
        //print("\(TokenObject(rawValue: token)?.description)")
        tokenName.text = TokenObject(rawValue: token)?.description as String!
    }
    
    func initView() {
        self.contentView.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
        
        //Token 欄位
        let tokenView = UIView()
        self.addSubview(tokenView)
        tokenView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        let tokenNameField = UIView()
        tokenNameField.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_5)
        tokenView.addSubview(tokenNameField)
        tokenNameField.snp.makeConstraints { (make) in
            make.left.equalTo(tokenView.snp.left)
            make.height.width.equalTo(tokenView.snp.height)
            make.centerY.equalToSuperview()
        }
        
        
        tokenName.text = "BTC"
        tokenName.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_white_50)
        tokenName.textAlignment = .center
        tokenName.font = tokenName.font.withSize(14)
        tokenName.sizeToFit()
        tokenNameField.addSubview(tokenName)
        tokenName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        
        editTokenValue.backgroundColor = UIColor.white
        editTokenValue.textColor = UIColor.black
        editTokenValue.keyboardType = .decimalPad
        editTokenValue.returnKeyType = .done
        editTokenValue.delegate = self
        editTokenValue.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        editTokenValue.leftViewMode = .always
        tokenView.addSubview(editTokenValue)
        editTokenValue.snp.makeConstraints { (make) in
            make.left.equalTo(tokenNameField.snp.right)
            make.height.equalTo(tokenView.snp.height)
            make.width.equalTo(160)
            make.centerY.equalToSuperview()
        }
        
        let img = UIImageView()
        img.image = UIImage(named:"icon_up_down_arrow")
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.centerX.equalToSuperview()
            make.top.equalTo(tokenView.snp.bottom).offset(16)
        }
        
        //USD 欄位
        let usdView = UIView()
        self.addSubview(usdView)
        usdView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.top.equalTo(img.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        let usdNameField = UIView()
        usdNameField.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_5)
        usdView.addSubview(usdNameField)
        usdNameField.snp.makeConstraints { (make) in
            make.left.equalTo(usdView.snp.left)
            make.height.width.equalTo(usdView.snp.height)
            make.centerY.equalToSuperview()
        }
        
        let dollarName = UILabel()
        dollarName.text = "USD"
        dollarName.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_white_50)
        dollarName.textAlignment = .center
        dollarName.font = dollarName.font.withSize(14)
        dollarName.sizeToFit()
        usdNameField.addSubview(dollarName)
        dollarName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        editUsdValue.backgroundColor = UIColor.white
        editUsdValue.textColor = UIColor.black
        editUsdValue.keyboardType = .decimalPad
        editUsdValue.returnKeyType = .done
        editUsdValue.delegate = self
        editUsdValue.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        editUsdValue.leftViewMode = .always
        usdView.addSubview(editUsdValue)
        editUsdValue.snp.makeConstraints { (make) in
            make.left.equalTo(usdNameField.snp.right)
            make.height.equalTo(usdView.snp.height)
            make.width.equalTo(160)
            make.centerY.equalToSuperview()
        }
    }
    
    func initTextFieldObserve() {
        //監聽使用者輸入Token數量
        editTokenValue.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                guard let inputValue = Double($0) else {return}
                
                print("匯率：\(self.usdExchangeRate*inputValue)")
                
                self.editUsdValue.text = String(self.usdExchangeRate*inputValue)
            })
            .disposed(by: disposeBag)
        
        //監聽使用者輸入美金數量
        editUsdValue.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                guard let inputValue = Double($0) else {return}
                let exchangedValue = inputValue/self.usdExchangeRate
                print("匯率：\(exchangedValue)")
                
                self.editTokenValue.text = String(exchangedValue)
            })
            .disposed(by: disposeBag)
    }
}
