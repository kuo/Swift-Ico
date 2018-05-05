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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let currentPriceLabel = UILabel()
        currentPriceLabel.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        currentPriceLabel.textAlignment = .center
        currentPriceLabel.text = "39.97"
        currentPriceLabel.font = currentPriceLabel.font.withSize(60)
        currentPriceLabel.sizeToFit()
        //currentPriceLabel.center = CGPoint(x: self.contentView.center.x, y: currentPriceLabel.center.y)
        self.addSubview(currentPriceLabel)
        
        currentPriceLabel.snp.makeConstraints { (make) in
            //make.width.equalTo(self.contentView.frame.width)
            //make.height.equalTo(60)
            make.top.equalTo(self).offset(30)
            make.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
