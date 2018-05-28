//
//  MoreInfoCell.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/19.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

class MoreInfoCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_gray_9)
        
        let more = UILabel()
        more.text = "More"
        more.textColor = UIColor(hexString:GlobalDefine.GPColors.kColor_theme_orange)
        more.sizeToFit()
        more.textAlignment = .right
        self.addSubview(more)
        
        more.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
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
