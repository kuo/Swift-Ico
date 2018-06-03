//
//  ChooseTokenCell.swift
//  IcoCenter
//
//  Created by Gash AD on 2018/5/17.
//  Copyright © 2018年 Gash AD. All rights reserved.
//

import Foundation
import UIKit

class ChooseTokenCell: UITableViewCell {
    
    let tokenIcon = UIImageView()
    let tokenName = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .blue
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor.black
        
        tokenIcon.image = UIImage(named:"bitcoin")
        tokenIcon.layer.masksToBounds = true
        tokenIcon.layer.cornerRadius = 25
        self.addSubview(tokenIcon)
        tokenIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
        tokenName.text = ""
        tokenName.textColor = UIColor.white
        tokenName.textAlignment = .left
        tokenName.font = tokenName.font.withSize(30)
        tokenName.sizeToFit()
        self.addSubview(tokenName)
        tokenName.snp.makeConstraints { (make) in
            make.left.equalTo(tokenIcon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.white
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(tokenName.snp.left)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(1)
            make.width.lessThanOrEqualToSuperview().offset(30)
            make.top.equalTo(tokenIcon.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateData(name:String, icon:String) {
        tokenName.text = name
        tokenIcon.image = UIImage(named:icon)
    }
}
