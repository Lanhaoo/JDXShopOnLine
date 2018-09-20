//
//  JDXBaseModel.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class JDXBaseModel:NSObject,HandyJSON,NSCoding{
    required override init() {
        
    }
    //使用MJExtension 快速实现编解码 主要用于 yycahe 实现本地缓存
    func encode(with aCoder: NSCoder) {
        self.mj_encode(aCoder)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.mj_decode(aDecoder)
    }
}
