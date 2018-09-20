//
//  JDXProfileMoneyItemView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/12.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXProfileMoneyItemView: UITableViewHeaderFooterView {
    var gridView = QMUIGridView()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        gridView.columnCount = 3
        gridView.rowHeight = self.frame.size.height
        gridView.separatorColor = UIColor.white
        gridView.backgroundColor = UIColor.white
        self.addSubview(gridView)
    }
    func setData(data:JDXCustomerASGetInfo){
        for item in data.rContentAsset{
            let bgView = UIView()
            bgView.backgroundColor = UIColor.white
            self.gridView.addSubview(bgView)

            let topLabel = UILabel()
            topLabel.textColor = UIColor.qmui_color(withHexString: "#000000")
            topLabel.font = UIFont.systemFont(ofSize: 12)
            topLabel.text = item.rCItemText
            bgView.addSubview(topLabel)

            let bottomTitle = UILabel()
            bottomTitle.textColor = UIColor.qmui_color(withHexString: "#5e5e5e")
            bottomTitle.font = UIFont.systemFont(ofSize: 14)
            bottomTitle.text = item.rCItem
            bgView.addSubview(bottomTitle)
            topLabel.snp.makeConstraints { (make) in
                make.top.equalTo(scaleWidth(width: 10.0))
                make.centerX.equalToSuperview()
            }
            bottomTitle.snp.makeConstraints { (make) in
                make.top.equalTo(topLabel.snp.bottom).offset(scaleWidth(width: 5.0))
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
