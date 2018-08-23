//
//  JDXBaseTableViewCell.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXBaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        jdx_addSubViews()
    }
    func jdx_addSubViews() {
        
    }
    public func setCellData(data:AnyObject?) {
        if let actualData = data as? JDXBaseModel {
            print(actualData.rADTitle)
            self.textLabel?.text = actualData.rADTitle
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
