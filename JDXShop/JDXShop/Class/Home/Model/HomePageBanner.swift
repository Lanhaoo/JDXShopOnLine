//
//  HomePageBanner.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class HomePageBanner: NSObject,HandyJSON,NSCoding {
    var rNum:String?
    var rPosition:String?
    var rOrder:String?
    var rTitle:String?
    var rPicture:String?
    var rPictureURL:String?
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
    //获取广告页
    public func fetchBannerData(complectedCallback:@escaping (_ result : Array<HomePageBanner>) -> ()){
        JDXNetService.requestForArrayResult(url: JDXApiDefine.recommented,
                                            params: ["sPosition":"1"],
                                            resultModel: HomePageBanner(),
                                            finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
}
