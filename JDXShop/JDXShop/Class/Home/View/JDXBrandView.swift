//
//  JDXBrandView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXBrandView: UICollectionReusableView {
    let gridView = QMUIGridView()
    let brand = JDXHomePageProductInfo()
    override init(frame: CGRect) {
        super.init(frame: frame)
        jdx_addSubViews()
    }
    func jdx_addSubViews() {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreen_Width, height: scaleHeight(height: 44.0)))
        topView.backgroundColor = UIColor.white
        self.addSubview(topView)
        let labelChinese = UILabel()
        labelChinese.text = "可能适合您的品牌"
        labelChinese.font = UIFont.systemFont(ofSize: 15)
        labelChinese.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        topView.addSubview(labelChinese)
        labelChinese.snp.makeConstraints { (make) in
            make.left.equalTo(scaleWidth(width: 10.0))
            make.centerY.equalToSuperview()
        }
        let labelEnglish = UILabel()
        labelEnglish.text = "BRAND FOR YOU"
        labelEnglish.font = UIFont.systemFont(ofSize: 14)
        labelEnglish.textColor = UIColor.qmui_color(withHexString: "#818181")
        topView.addSubview(labelEnglish)
        labelEnglish.snp.makeConstraints { (make) in
            make.left.equalTo(labelChinese.snp.right).offset(scaleWidth(width: 10.0))
            make.centerY.equalToSuperview()
        }
        
        gridView.frame = CGRect.init(x: 0, y:topView.frame.size.height+scaleHeight(height: 1.0), width: kScreen_Width, height: scaleHeight(height: 188.0))
        gridView.columnCount = 4
    
        gridView.separatorWidth = scaleWidth(width: 1.0)
        gridView.separatorColor = UIColor.qmui_color(withHexString: "#f5f5f5")
        
        gridView.rowHeight = scaleHeight(height: 94.0)
        gridView.backgroundColor = UIColor.white
        self.addSubview(gridView)
        
        brand.loadBrandData(complectedCallback: { (result) in
            for item in result{
                let btnBGView = UIView()
                btnBGView.backgroundColor = UIColor.white
                self.gridView.addSubview(btnBGView)
                let itemImageView = UIImageView()
                itemImageView.showImage(url: item.rPictureURL, placeholder: nil)
                btnBGView.addSubview(itemImageView)
                itemImageView.snp.makeConstraints({ (make) in
                    make.edges.equalToSuperview()
                })
            }
        }) {
            
        }
        
        let bottomView = UIView()
        self.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.white
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(gridView.snp.bottom).offset(scaleHeight(height: 1.0))
            make.left.equalTo(0)
            make.width.equalTo(kScreen_Width)
            make.height.equalTo(scaleHeight(height: 56.0))
        }
        let labelContainerView = UIView.init(frame: CGRect.init(x: 0, y: scaleHeight(height: 10.0), width: kScreen_Width, height: scaleHeight(height: 46.0)))
        labelContainerView.backgroundColor = UIColor.qmui_color(withHexString: "#ffe53a")
        bottomView.addSubview(labelContainerView)

        let label1 = UILabel()
        label1.textColor = UIColor.qmui_color(withHexString: "#222222")
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.text = "热门推荐"
        label1.textAlignment = NSTextAlignment.center
        labelContainerView.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(scaleHeight(height: 10.0))
            make.width.equalTo(kScreen_Width)
            make.height.equalTo(scaleHeight(height: 15.0))
        }
    
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.center;
        label2.textColor = UIColor.qmui_color(withHexString: "#222222")
        label2.font = UIFont.systemFont(ofSize: 13)
        label2.text = "HOT SALES RECOMMENDATION"
        labelContainerView.addSubview(label2)
        
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(scaleHeight(height: 4.0))
            make.width.equalTo(kScreen_Width)
            make.height.equalTo(scaleHeight(height: 10.0))
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}