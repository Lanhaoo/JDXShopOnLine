//
//  JDXProfileOrderItemView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/12.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXProfileOrderItemView: UITableViewHeaderFooterView {
    var gridView = QMUIGridView()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        gridView.columnCount = 4
        gridView.rowHeight = self.frame.size.height
        gridView.separatorColor = UIColor.white
        gridView.backgroundColor = UIColor.white
        self.addSubview(gridView)
    }
    func setData(data:JDXCustomerASGetInfo){
        for item in data.rContentOrder{
            let bgView = UIView()
            bgView.backgroundColor = UIColor.white
            self.gridView.addSubview(bgView)
            
            let icon = UIImageView()
            icon.showImage(url: item.rCItemPicture, placeholder: nil)
            bgView.addSubview(icon)
            
            let title = UILabel()
            title.textColor = UIColor.qmui_color(withHexString: "#555555")
            title.font = UIFont.systemFont(ofSize: 12)
            title.text = item.rCItem
            bgView.addSubview(title)
            
            icon.snp.makeConstraints { (make) in
                make.top.equalTo(scaleWidth(width: 10.0))
                make.width.height.equalTo(scaleWidth(width: 24.0))
                make.centerX.equalToSuperview()
            }
            
            title.snp.makeConstraints { (make) in
                make.top.equalTo(icon.snp.bottom).offset(scaleWidth(width: 6.0))
                make.centerX.equalToSuperview()
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gridView.frame = self.bounds
        self.gridView.rowHeight = self.bounds.size.height
    }
}
