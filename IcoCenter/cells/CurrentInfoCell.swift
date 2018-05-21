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
        
        
        currentPriceLabel.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        currentPriceLabel.textAlignment = .center
        currentPriceLabel.text = "39.97"
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
        pricebefore_hour_1.text = "1h漲幅\n39.97"
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
        pricebefore_hour_24.text = "24hr漲幅\n39.97"
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
        pricebefore_hour_1.text = "1hr漲幅\n" + data.percentChange_1h + "%"
        pricebefore_hour_24.text = "24hr漲幅\n" + data.percentChange_24h + "%"
    }
}
