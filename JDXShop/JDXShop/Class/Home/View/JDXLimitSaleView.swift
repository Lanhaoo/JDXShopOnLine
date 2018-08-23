//
//  JDXLimitSaleView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/20.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

protocol JDXLimitSaleViewProtocol {
    func handleSelectedTimeLimitItem()
    func handleSelectedInternalItem()
}

class JDXLimitSaleView: UICollectionReusableView {
    let gridView = QMUIGridView()
    let productModel = JDXHomePageProductInfo()
    let timeLimitItemSaleView = JDXLimitItemView()
    let internalLimitItemSaleView = JDXLimitItemView()
    var delegate:JDXLimitSaleViewProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        jdx_addSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func jdx_addSubViews() {
        gridView.frame = CGRect.init(x: 0, y:0, width: kScreen_Width, height: scaleWidth(width: 253.0))
        gridView.columnCount = 2
        gridView.rowHeight = scaleWidth(width: 253.0)
        gridView.backgroundColor = UIColor.white
        
        gridView.separatorWidth = scaleWidth(width: 1.0)
        gridView.separatorColor = UIColor.qmui_color(withHexString: "#f5f5f5")
        
        self.addSubview(gridView)
        self.gridView.addSubview(self.timeLimitItemSaleView)
        self.gridView.addSubview(self.internalLimitItemSaleView)
        
        //获取限时特卖
        productModel.loadTimeLimitSaleData(complectedCallback: { (result) in
            for item in result{
                self.timeLimitItemSaleView.updateUI(data: item)
            }
            //添加手势
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.selectedTimeLimitView))
            self.timeLimitItemSaleView.addGestureRecognizer(tap)
        }) {
            
        }
        //获取尚妆国际
        productModel.loadInternalLimitSaleData(complectedCallback: { (result) in
            for item in result{
                self.internalLimitItemSaleView.updateUI(data: item)
            }
            //添加手势
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.selectedInterNalView))
            self.internalLimitItemSaleView.addGestureRecognizer(tap)
        }) {
            
        }
    }
    
    @objc func selectedTimeLimitView() {
        if let actualDelegate = self.delegate{
            actualDelegate.handleSelectedTimeLimitItem()
        }
    }
    @objc func selectedInterNalView() {
        if let actualDelegate = self.delegate{
            actualDelegate.handleSelectedInternalItem()
        }
    }
}
class JDXLimitItemView: JDXBaseView {
    lazy var titleLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        return label
    }()
    lazy var rightMoreIocn:UIImageView = {
        var icon = UIImageView()
        return icon
    }()
    lazy var subTitleLabel:UILabel = {
        var label = UILabel()
        label.textColor = UIColor.qmui_color(withHexString: "#8d8d8d")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var productImageView:UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    lazy var countDownLabel:UILabel={
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.qmui_color(withHexString: "#ff8b2d")
        return label
    }()
    lazy var priceLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.qmui_color(withHexString: "#ff8b2d")
        return label
    }()
    lazy var productNameLabel : UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        return label
    }()
    override func jdx_addSubViews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.rightMoreIocn)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.productImageView)
        self.addSubview(self.countDownLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.productNameLabel)
        makeConstraints()
    }
    //自动布局
    func makeConstraints() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(scaleWidth(width: 12.0))
            make.top.equalTo(scaleWidth(width: 20.0))
            make.height.equalTo(scaleWidth(width: 16.0))
        }
        self.rightMoreIocn.snp.makeConstraints { (make) in
            make.right.equalTo(-scaleWidth(width: 10.0))
            make.width.height.equalTo(scaleWidth(width: 18.0))
            make.centerY.equalTo(self.titleLabel)
        }
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(scaleWidth(width: 9.0))
            make.height.equalTo(scaleWidth(width: 13.0))
        }
        self.productImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.subTitleLabel.snp.bottom).offset(scaleWidth(width: 2.0))
            make.width.height.equalTo(scaleWidth(width: 133.0))
        }
        self.countDownLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.productImageView.snp.bottom).offset(-scaleWidth(width: 10.0))
            make.height.equalTo(scaleWidth(width: 19.0))
        }
        self.priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.countDownLabel.snp.bottom).offset(scaleWidth(width: 7.0))
            make.height.equalTo(scaleWidth(width: 13.0))
        }
        self.productNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.priceLabel.snp.bottom).offset(scaleWidth(width: 8.0))
            make.height.equalTo(scaleWidth(width: 13.0))
        }
    }
    func updateUI(data:JDXHomePageProductInfo) {
        self.titleLabel.text = data.rTitle
        self.subTitleLabel.text = data.rADEnglish
        self.productImageView.showImage(url: data.rPictureURL, placeholder: nil)
        self.priceLabel.text = "¥"+data.rADPrice!
        self.productNameLabel.text = data.rADTitle
    }
}
