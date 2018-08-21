//
//  JDXHomePageProductInfo.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/16.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class JDXHomePageProductInfo: NSObject,HandyJSON {
    var Num:String?
    var rADChinese:String?
    var rADEnglish:String?
    var rADPrice:String?
    var rADTitle:String?
    var rDownTime:String?
    var rOpenKind:String?
    var rOpenParam:String?
    var rOrder:String?
    var rPicture:String?
    var rPictureURL:String?
    var rPosition:String?
    var rStatu:String?
    var rTitle:String?
    var rUpTime:String?
    required override init() {
        
    }
    //获取 限时特卖
    public func loadTimeLimitSaleData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        var dataRecords:Array<JDXHomePageProductInfo> = Array<JDXHomePageProductInfo>()
        JDXNetService.startRequest(url: JDXApiDefine.recommendPageGet, params: ["sPosition":2,"iPageNo":1,"iPagePer":10], finishedCallback: { (result) in
            if let actualData = result.data as? Array<Any>{
                for item in actualData{
                    print(item)
                    if let object = JDXHomePageProductInfo.deserialize(from: item as? Dictionary){
                        dataRecords.append(object)
                    }
                }
            }
            complectedCallback(dataRecords)
        }) { (error) in
            
        }
    }
    //获取 尚妆国际
    public func loadInternalLimitSaleData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
            var dataRecords:Array<JDXHomePageProductInfo> = Array<JDXHomePageProductInfo>()
            JDXNetService.startRequest(url: JDXApiDefine.recommendPageGet, params: ["sPosition":3,"iPageNo":1,"iPagePer":10], finishedCallback: { (result) in
                if let actualData = result.data as? Array<Any>{
                    for item in actualData{
                        print(item)
                        if let object = JDXHomePageProductInfo.deserialize(from: item as? Dictionary){
                            dataRecords.append(object)
                        }
                    }
                }
                complectedCallback(dataRecords)
            }) { (error) in
                
            }
    }
    //获取 热门推荐
    public func loadProductData(page:Int,pageSize:Int,complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        var dataRecords:Array<JDXHomePageProductInfo> = Array<JDXHomePageProductInfo>()
        JDXNetService.startRequest(url: JDXApiDefine.recommendPageGet, params: ["sPosition":"6","iPageNo":page,"iPagePer":pageSize], finishedCallback: { (result) in
            if let actualData = result.data as? Array<Any>{
                
                for item in actualData{
                    if let object = JDXHomePageProductInfo.deserialize(from: item as? Dictionary){
                        dataRecords.append(object)
                    }
                }
                
            }
            complectedCallback(dataRecords)
        }) { (error) in
            print(error)
        }
    }
    //获取 热门分类
    public func loadClassifyData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        var dataRecords:Array<JDXHomePageProductInfo> = Array<JDXHomePageProductInfo>()
        JDXNetService.startRequest(url: JDXApiDefine.recommendPageGet, params: ["sPosition":"5","iPageNo":1,"iPagePer":10], finishedCallback: { (result) in
            if let actualData = result.data as? Array<Any>{
                for item in actualData{
                    if let object = JDXHomePageProductInfo.deserialize(from: item as? Dictionary){
                        dataRecords.append(object)
                    }
                }
            }
            complectedCallback(dataRecords)
        }) { (error) in
            print(error)
        }
    }
    //获取 品牌
    public func loadBrandData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        var dataRecords:Array<JDXHomePageProductInfo> = Array<JDXHomePageProductInfo>()
        JDXNetService.startRequest(url: JDXApiDefine.recommendPageGet, params: ["sPosition":"4","iPageNo":1,"iPagePer":10], finishedCallback: { (result) in
            if let actualData = result.data as? Array<Any>{
                for item in actualData{
                    if let object = JDXHomePageProductInfo.deserialize(from: item as? Dictionary){
                        dataRecords.append(object)
                    }
                }
            }
            complectedCallback(dataRecords)
        }) { (error) in
            print(error)
        }
    }
}
