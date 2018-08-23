//
//  JDXTimeLimitSaleCell.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/23.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXTimeLimitSaleCell: JDXBaseTableViewCell {
    var productImageView:UIImageView!
    var productTitleLabel:UILabel!
    var descLabel:UILabel!
    var salePriceLabel:UILabel!
    var oldPriceLabel:UILabel!
    var saleBtn:UIButton!
    override func jdx_addSubViews() {
        
        productImageView = UIImageView()
        self.addSubview(productImageView)
        
        productTitleLabel = UILabel()
        productTitleLabel.numberOfLines = 1
        self.addSubview(productTitleLabel)
        
        descLabel = UILabel()
        descLabel.numberOfLines = 2
        self.addSubview(descLabel)
        
        salePriceLabel = UILabel()
        self.addSubview(salePriceLabel)
        
        oldPriceLabel = UILabel()
        self.addSubview(oldPriceLabel)
        
        saleBtn = UIButton()
        saleBtn.setTitle("去抢购", for: UIControlState.normal)
        saleBtn.backgroundColor = UIColor.qmui_color(withHexString: "#ffe53a")
        self.addSubview(saleBtn)
        
        makeConstraints()
    }
    override func setCellData(data: AnyObject?) {
        if let actualData = data as? JDXTimeLimitRowData{
            self.productImageView.showImage(url: actualData.rPictureURL, placeholder: nil)
            self.productTitleLabel.text = actualData.rTitle
            self.descLabel.text = actualData.rADTitle
            self.salePriceLabel.text = actualData.rADPrice
            self.oldPriceLabel.text = actualData.rADPrice
        }
    }
    func makeConstraints(){
        self.productImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(scaleWidth(width: 120.0))
            make.left.equalTo(scaleWidth(width: 10.0))
            make.bottom.equalToSuperview()
        }
        
        self.productTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.productImageView.snp.right).offset(scaleWidth(width: 10.0))
            make.right.equalTo(-scaleWidth(width: 10.0))
            make.top.equalTo(scaleWidth(width: 17.0))
            make.height.equalTo(scaleWidth(width: 13.0))
        }
        
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.productTitleLabel)
            make.top.equalTo(self.productTitleLabel.snp.bottom).offset(-scaleWidth(width: 8.0))
            make.right.equalTo(self.productTitleLabel)
        }
    
        self.saleBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.productTitleLabel)
            make.width.equalTo(scaleWidth(width: 80.0))
            make.height.equalTo(scaleWidth(width: 38.0))
            make.bottom.equalTo(-scaleWidth(width: 8.0))
        }
        
        self.salePriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.productTitleLabel)
            make.top.equalTo(self.descLabel.snp.bottom).offset(scaleWidth(width: 22.0))
        }
        self.oldPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.productTitleLabel)
            make.top.equalTo(self.salePriceLabel.snp.bottom).offset(scaleWidth(width: 7.0))
        }
    }

}
