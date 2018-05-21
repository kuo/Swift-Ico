//
//  ExchangeCell.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/9.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

class ExchangeCell: UITableViewCell, UITextFieldDelegate {
    
    var editTokenValue = UITextField()
    var editUsdValue = UITextField()
    var usdExchangeRate:Double = 0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
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
        tokenNameField.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_4)
        tokenView.addSubview(tokenNameField)
        tokenNameField.snp.makeConstraints { (make) in
            make.left.equalTo(tokenView.snp.left)
            make.height.width.equalTo(tokenView.snp.height)
            make.centerY.equalToSuperview()
        }
        
        let tokenName = UILabel()
        tokenName.text = "BTC"
        tokenName.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        tokenName.textAlignment = .center
        tokenName.font = tokenName.font.withSize(14)
        tokenName.sizeToFit()
        tokenNameField.addSubview(tokenName)
        tokenName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        
        editTokenValue.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_header_bg)
        editTokenValue.textColor = UIColor.white
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
        img.image = UIImage(named:"img_arrow")
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
        usdNameField.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_4)
        usdView.addSubview(usdNameField)
        usdNameField.snp.makeConstraints { (make) in
            make.left.equalTo(usdView.snp.left)
            make.height.width.equalTo(usdView.snp.height)
            make.centerY.equalToSuperview()
        }
        
        let dollarName = UILabel()
        dollarName.text = "USD"
        dollarName.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        dollarName.textAlignment = .center
        dollarName.font = dollarName.font.withSize(14)
        dollarName.sizeToFit()
        usdNameField.addSubview(dollarName)
        dollarName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        editUsdValue.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_header_bg)
        editUsdValue.textColor = UIColor.white
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == self.editTokenValue) {
            if range.location >= 7 {
                return false
            } else {
                return true
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func updateExchangeRate(model:CurrentPriceModel?) {
        guard let data = model else {return}
        
        self.usdExchangeRate = Double(data.priceUsd)!
        
        editTokenValue.text = "1"
        editUsdValue.text = data.priceUsd
    }
}
