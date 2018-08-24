//
//  JDXCustomScrollView.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/24.
//  Copyright © 2018年 3. All rights reserved.
//

/*
 对 SDCycleScrollView 进行一些自定义
 */
import UIKit

class JDXCustomScrollView: SDCycleScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
