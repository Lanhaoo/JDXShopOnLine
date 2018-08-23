//
//  JDXKindMenuView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/20.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXKindMenuView: UICollectionReusableView {
    let gridView = QMUIGridView()
    let classifyModel = JDXHomePageProductInfo()
    override init(frame: CGRect) {
        super.init(frame: frame)
        jdx_addSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func jdx_addSubViews() {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreen_Width, height: scaleWidth(width: 27.0)))
        topView.backgroundColor = UIColor.white
        self.addSubview(topView)
        
        let leftLabel = UILabel()
        leftLabel.text = "热门分类"
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        topView.addSubview(leftLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(scaleWidth(width: 10.0))
            make.centerY.equalToSuperview()
        }
        
        
        let rightLabel = UILabel()
        rightLabel.text = "更多分类 >"
        rightLabel.font = UIFont.systemFont(ofSize: 12)
        rightLabel.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        topView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-scaleWidth(width: 10.0))
            make.centerY.equalToSuperview()
        }
        
        gridView.frame = CGRect.init(x: 0, y:topView.frame.size.height+scaleHeight(height: 1.0), width: kScreen_Width, height: scaleWidth(width: 165.0))
        gridView.columnCount = 4
        gridView.rowHeight = scaleWidth(width: 80.0)
        gridView.backgroundColor = UIColor.white
        self.addSubview(gridView)
        
        //添加子视图
        classifyModel.loadClassifyData(complectedCallback: { (result) in
            for item in result{
                let btnBGView = UIView()
                btnBGView.backgroundColor = UIColor.white
                self.gridView.addSubview(btnBGView)
                
                let topImageView = UIImageView()
                topImageView.showImage(url: item.rPictureURL, placeholder: nil)
                btnBGView.addSubview(topImageView)
                topImageView.snp.makeConstraints({ (make) in
                    make.width.equalTo(scaleWidth(width: 48.0))
                    make.height.equalTo(scaleWidth(width: 48.0))
                    make.centerX.equalToSuperview()
                    make.top.equalTo(scaleWidth(width: 5.0))
                })
                
                let bottomLabel = UILabel()
                bottomLabel.textColor = UIColor.qmui_color(withHexString: "#666666")
                bottomLabel.font = UIFont.systemFont(ofSize: 14)
                bottomLabel.text = item.rTitle
                btnBGView.addSubview(bottomLabel)
                bottomLabel.snp.makeConstraints({ (make) in
                    make.top.equalTo(topImageView.snp.bottom).offset(scaleWidth(width: 7.0))
                    make.centerX.equalToSuperview()
                    make.height.equalTo(scaleWidth(width: 13.0))
                })
            }
        }) {
            
        }
    }
}
