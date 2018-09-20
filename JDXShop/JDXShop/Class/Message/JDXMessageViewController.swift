//
//  JDXMessageViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXMessageViewController: UIViewController {
    let firstCellBackGroundImageUrl = "/img/100001/100000000002.png"
    let secondCellBackGroundImageUrl = "/img/100001/100000000003.png"
    let thirdCellBackGroundImageUrl = "/img/100001/100000000004.png"
    let firstCell = UIImageView()
    let secondCell = UIImageView()
    let thirdCell = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "消息"
        self.view.addSubview(firstCell)
        self.view.addSubview(secondCell)
        self.view.addSubview(thirdCell)
        
        self.firstCell.showImage(url: imageBaseUrl+firstCellBackGroundImageUrl, placeholder: nil)
        self.secondCell.showImage(url: imageBaseUrl+secondCellBackGroundImageUrl, placeholder: nil)
        self.thirdCell.showImage(url: imageBaseUrl+thirdCellBackGroundImageUrl, placeholder: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.firstCell.snp.makeConstraints { (make) in
            make.width.equalTo(scaleWidth(width: 330.0))
            make.height.equalTo(scaleWidth(width: 125.0))
            make.centerX.equalToSuperview()
            make.top.equalTo(scaleWidth(width: 50.0))
        }
        
        self.secondCell.snp.makeConstraints { (make) in
            make.width.equalTo(scaleWidth(width: 330.0))
            make.height.equalTo(scaleWidth(width: 125.0))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.firstCell.snp.bottom).offset(scaleWidth(width: 50.0))
        }
        
        self.thirdCell.snp.makeConstraints { (make) in
            make.width.equalTo(scaleWidth(width: 330.0))
            make.height.equalTo(scaleWidth(width: 125.0))
            make.centerX.equalToSuperview()
            make.top.equalTo(self.secondCell.snp.bottom).offset(scaleWidth(width: 50.0))
        }
        
    }
}
