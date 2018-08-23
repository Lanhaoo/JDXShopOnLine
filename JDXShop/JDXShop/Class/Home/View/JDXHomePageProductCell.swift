//
//  JDXHomePageProductCell.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/18.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
class JDXHomePageProductCell: JDXBaseCollectionViewCell {
    let productImageView:UIImageView = {
        var imageView = UIImageView.init()
        return imageView
    }()
    let titleLabel:UILabel = {
       var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        return label
    }()
    let priceLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.qmui_color(withHexString: "#ff9c00")
        return label
    }()
    override func jdx_addSubViews() {
        self.backgroundColor = UIColor.white
        self.addSubview(self.productImageView)
        self.productImageView.snp.makeConstraints { (make) in
            make.width.equalTo(scaleWidth(width: 147.0))
            make.height.equalTo(scaleWidth(width: 150.0))
            make.centerX.equalToSuperview()
            make.top.equalTo(scaleWidth(width: 25.0))
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.productImageView.snp.bottom).offset(scaleWidth(width: 20.0))
            make.left.equalTo(scaleWidth(width: 10.0))
            make.right.equalTo(-scaleWidth(width: 10.0))
            make.height.equalTo(scaleWidth(width: 13.0))
        }
        self.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(scaleWidth(width: 7.0))
            make.left.equalTo(scaleWidth(width: 10.0))
            make.right.equalTo(-scaleWidth(width: 10.0))
            make.height.equalTo(scaleWidth(width: 13.0))
        }
    }
    
    override func setCellData(data: AnyObject?) {
        if let actualData = data{
            let info:JDXHomePageProductInfo = actualData as! JDXHomePageProductInfo
            self.productImageView.showImage(url: info.rPictureURL, placeholder: nil)
            self.titleLabel.text = info.rADTitle
            self.priceLabel.text = info.rADPrice
        }
    }
}
