//
//  JDXCategoryItemView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/11.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXCategoryItemView: JDXBaseView {
    let gridView = QMUIGridView()
    let titleLabel = UILabel()
    var titleStr:String?{
        didSet{
            self.titleLabel.text = titleStr
        }
    }
    override func jdx_addSubViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.qmui_color(withHexString: "#5a5a5a")
        self.addSubview(titleLabel)
        gridView.columnCount = 3
        gridView.rowHeight = scaleWidth(width: 45.0)
        gridView.separatorColor = UIColor.white
        gridView.backgroundColor = UIColor.white
        self.addSubview(gridView)
    }
    func setData(data:Array<JDXRecommendGetInfo>) {
        for item in data{
            let btnBGView = UIView()
            btnBGView.backgroundColor = UIColor.white
            self.gridView.addSubview(btnBGView)
            let btn = UIButton()
            btn.setTitle(item.rTitle, for: .normal)
            btn.setTitleColor(UIColor.qmui_color(withHexString: "#5a5a5a"), for: .normal)
            btn.layer.borderWidth = 0.5;
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.layer.borderColor = UIColor.qmui_color(withHexString: "#cfcfcf").cgColor
            btnBGView.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(scaleWidth(width: 108.0))
                make.height.equalTo(scaleWidth(width: 35.0))
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(scaleWidth(width: 30.0))
            make.top.right.equalToSuperview()
            make.left.equalTo(scaleWidth(width: 10.0))
        }
        gridView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
