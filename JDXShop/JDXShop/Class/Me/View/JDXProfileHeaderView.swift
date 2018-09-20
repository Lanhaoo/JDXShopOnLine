//
//  JDXProfileHeaderView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/11.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXProfileHeaderView: JDXBaseView {
    var headImageView = UIImageView()
    var nickNameLabel = UILabel()
    let bottomBGImageViewUrl = "/img/100001/100000000019.png"
    let headImageUrl = "/img/100001/100000000006.png"
    let bottomBGImageView = UIImageView()
    override func jdx_addSubViews() {
        self.backgroundColor = UIColor.qmui_color(withHexString: "#ffe53a")
        self.addSubview(self.headImageView)
        self.addSubview(self.nickNameLabel)
        self.addSubview(self.bottomBGImageView)
        self.bottomBGImageView.showImage(url: imageBaseUrl+bottomBGImageViewUrl, placeholder: nil)
        self.nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.nickNameLabel.textColor = UIColor.qmui_color(withHexString: "#333333")
    }
    func setData(data:JDXCustomerASGetInfo) {
        if let name = data.rCName {
            if (name.characters.count>0){
                self.nickNameLabel.text = name
            }else{
                self.nickNameLabel.text = "昵称"
            }
        }else{
            self.nickNameLabel.text = "昵称"
        }
        self.headImageView.showImage(url: imageBaseUrl+headImageUrl, placeholder: nil)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraints()
    }
    func makeConstraints() {
        self.headImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(scaleWidth(width: 80.0))
            make.top.equalTo(scaleWidth(width: 15.0))
        }
        self.nickNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.headImageView.snp.bottom).offset(scaleWidth(width: 15.0))
        }
        
        self.bottomBGImageView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(scaleWidth(width: 60.0))
        }
    }

}
