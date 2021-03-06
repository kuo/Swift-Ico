//
//  HistoryCell.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/3.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import SnapKit

class HistoryCell: UITableViewCell {
    
    var dateLabel = UILabel()
    var priceLabel = UILabel()
    var gainsLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
        
        dateLabel.numberOfLines = 0
        dateLabel.textColor = UIColor.white
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(self).multipliedBy(0.33)
        }
        
        priceLabel.numberOfLines = 0
        priceLabel.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        priceLabel.text = ""
        priceLabel.textAlignment = .center
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(self).multipliedBy(0.33)
            make.centerX.equalToSuperview()
        }
        
        gainsLabel.numberOfLines = 0
        gainsLabel.text = ""
        gainsLabel.textAlignment = .right
        self.addSubview(gainsLabel)
        gainsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(self).multipliedBy(0.33)
            make.right.equalToSuperview().offset(-35)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateData(data:DayData) {
        dateLabel.text = data.date
        priceLabel.text = String(data.price_usd)
        gainsLabel.text = data.percent_change_24h + "%"
        if data.percent_change_24h.starts(with: "-") {
            gainsLabel.textColor = UIColor.green
        } else {
            gainsLabel.textColor = UIColor.red
        }
    }
    
}
