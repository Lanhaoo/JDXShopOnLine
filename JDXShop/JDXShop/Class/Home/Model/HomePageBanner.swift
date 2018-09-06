//
//  HomePageBanner.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class HomePageBanner: NSObject,HandyJSON {
    var rNum:String?
    var rPosition:String?
    var rOrder:String?
    var rTitle:String?
    var rPicture:String?
    var rPictureURL:String?
    required override init() {
        
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
