//
//  JDXHomePageProductInfo.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/16.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class JDXHomePageProductInfo: NSObject,HandyJSON,NSCoding {
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
    //使用MJExtension 快速实现编解码 主要用于 yycahe 实现本地缓存
    func encode(with aCoder: NSCoder) {
        self.mj_encode(aCoder)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.mj_decode(aDecoder)
    }
    //获取 限时特卖
    public func loadTimeLimitSaleData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        JDXNetService.requestForArrayResult(url: JDXApiDefine.recommendPageGet, params: ["sPosition":2,"iPageNo":1,"iPagePer":10], resultModel: JDXHomePageProductInfo(), finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
    //获取 尚妆国际
    public func loadInternalLimitSaleData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        JDXNetService.requestForArrayResult(url: JDXApiDefine.recommendPageGet, params: ["sPosition":3,"iPageNo":1,"iPagePer":10], resultModel: JDXHomePageProductInfo(), finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
    //获取 热门推荐
    public func loadProductData(page:Int,pageSize:Int,complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        JDXNetService.requestForArrayResult(url: JDXApiDefine.recommendPageGet, params: ["sPosition":"6","iPageNo":page,"iPagePer":pageSize], resultModel: JDXHomePageProductInfo(), finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
    //获取 热门分类
    public func loadClassifyData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        JDXNetService.requestForArrayResult(url: JDXApiDefine.recommendPageGet, params: ["sPosition":"5","iPageNo":1,"iPagePer":10], resultModel: JDXHomePageProductInfo(), finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
    //获取 品牌
    public func loadBrandData(complectedCallback:@escaping (_ result : Array<JDXHomePageProductInfo>) -> (),failCallback:()->()){
        JDXNetService.requestForArrayResult(url: JDXApiDefine.recommendPageGet, params: ["sPosition":"4","iPageNo":1,"iPagePer":10], resultModel: JDXHomePageProductInfo(), finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
}
