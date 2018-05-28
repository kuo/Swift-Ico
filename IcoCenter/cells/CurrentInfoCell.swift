//
//  CurrentInfoCell.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/5.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

class CurrentInfoCell: UITableViewCell {
    
    var currentPriceLabel = UILabel()
    var pricebefore_hour_1 = UILabel()
    var pricebefore_hour_24 = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
        
        currentPriceLabel.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        currentPriceLabel.textAlignment = .center
        currentPriceLabel.font = currentPriceLabel.font.withSize(40)
        currentPriceLabel.sizeToFit()
        self.addSubview(currentPriceLabel)
        currentPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalToSuperview()
        }
        
        pricebefore_hour_1.numberOfLines = 2
        pricebefore_hour_1.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        pricebefore_hour_1.textAlignment = .left
        pricebefore_hour_1.font = pricebefore_hour_1.font.withSize(16)
        pricebefore_hour_1.sizeToFit()
        self.addSubview(pricebefore_hour_1)
        pricebefore_hour_1.snp.makeConstraints { (make) in
            make.top.equalTo(currentPriceLabel.snp.bottom)
            make.left.equalTo(self).offset(30)
        }
        
        pricebefore_hour_24.numberOfLines = 2
        pricebefore_hour_24.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        pricebefore_hour_24.textAlignment = .right
        pricebefore_hour_24.font = pricebefore_hour_1.font.withSize(16)
        pricebefore_hour_24.sizeToFit()
        self.addSubview(pricebefore_hour_24)
        pricebefore_hour_24.snp.makeConstraints { (make) in
            make.top.equalTo(currentPriceLabel.snp.bottom)
            make.right.equalTo(-30)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCurrentPriceData(model:CurrentPriceModel?) {
        guard let data = model else {return}
        
        currentPriceLabel.text = data.priceUsd
        
        let stringAttributes: [NSAttributedStringKey : Any] = [.foregroundColor : UIColor.white]
        let stringAttributesUp: [NSAttributedStringKey : Any] = [.foregroundColor : UIColor.red]
        let stringAttributesDown: [NSAttributedStringKey : Any] = [.foregroundColor : UIColor.green]
        
        let string_1hr = NSAttributedString(string: "1小時漲幅\n", attributes: stringAttributes)
        let string_24hr = NSAttributedString(string: "24小時漲幅\n", attributes: stringAttributes)
        var string_gains_1hr = NSAttributedString()
        var string_gains_24hr = NSAttributedString()
        
        if data.percentChange_1h.starts(with: "-") {
            string_gains_1hr = NSAttributedString(string: data.percentChange_1h + "%", attributes: stringAttributesDown)
        } else {
            string_gains_1hr = NSAttributedString(string: data.percentChange_1h + "%", attributes: stringAttributesUp)
        }
        
        if data.percentChange_24h.starts(with: "-") {
            string_gains_24hr = NSAttributedString(string: data.percentChange_1h + "%", attributes: stringAttributesDown)
        } else {
            string_gains_24hr = NSAttributedString(string: data.percentChange_1h + "%", attributes: stringAttributesUp)
        }
        
        let attrString_1h = NSMutableAttributedString()
        attrString_1h.append(string_1hr)
        attrString_1h.append(string_gains_1hr)
        
        let attrString_24h = NSMutableAttributedString()
        attrString_24h.append(string_24hr)
        attrString_24h.append(string_gains_24hr)
        
        pricebefore_hour_1.attributedText = attrString_1h
        pricebefore_hour_24.attributedText = attrString_24h
    }
}
