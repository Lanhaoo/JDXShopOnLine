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
        var banners:Array<HomePageBanner> = Array<HomePageBanner>()
//        JDXNetService.startRequest(url: JDXApiDefine.recommented, params: ["sPosition":"1"], finishedCallback: { (result) in
//            if let actualData = result.data{
//                for item in actualData as! Array<Any>{
//                    if let object = HomePageBanner.deserialize(from: item as? Dictionary){
//                        banners.append(object)
//                    }
//                }
//            }
//            complectedCallback(banners)
//        }) {
//
//        }
 
    
    
    
    }

}
