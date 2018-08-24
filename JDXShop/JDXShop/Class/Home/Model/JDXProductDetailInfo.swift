//
//  JDXProductDetailInfo.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/24.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class JDXProductDetailInfo: NSObject,HandyJSON {
    var rAxisDefaultNum:String?
    var rAxisDefaultPrice:String?
    var rContent:Array<rContent>? = Array<rContent>()
    var rContentExpressFee:Array<rContentExpressFee>? = Array<rContentExpressFee>()
    var rContentIntroduction:rContentIntroduction?
    var rContentPParam:Array<rContentPParam>?=Array<rContentPParam>()
    var rContentPicture:Array<rContentPicture>? = Array<rContentPicture>()
    var rPAdd:String?
    var rPDNum:String?
    var rPMaxPrice:String?
    var rPMinPrice:String?
    var rPNum:String?
    var rPOPrice:String?
    var rPSAmount:String?
    var rPSaleAmount:String?
    var rPSendPlace:String?
    var rPTimeDown:String?
    var rPTimeUp:String?
    var rPTitle:String?
    var rPTitleSec:String?
    var rProductID:String?
    var rSNum:String?
    var rShopName:String?
    var rVideo:String?
    var rVideoCoverURL1:String?
    var rVideoURL:String?
    var rcontentAxis:Array<rcontentAxis> = Array<rcontentAxis>()
    required override init() {
        
    }
}
class rContent: NSObject,HandyJSON {
    var title:String?
    var rcontent:Array<rcontent> = Array<rcontent>()
    required override init() {
        
    }
}
class rcontent: NSObject,HandyJSON {
    var rCouponAllCan:String?
    var rCouponCan:String?
    var rCouponCode:String?
    var rCouponPicture:String?
    var rSaleAllMoney:String?
    var rSaleCutMoney:String?
    var rSaleKind:String?
    var rSaleName:String?
    var rSaleNum:String?
    var rSaleRangeKind:String?
    var rSaleValidityTimeB:String?
    var rSaleValidityTimeE:String?
    required override init() {
        
    }
}
class rContentExpressFee: NSObject,HandyJSON {
    var rExpressFee:String?
    var rExpressFree:String?
    var rExpressName:String?
    var rExpressNum:String?
    var rExpressProvince:String?
    required override init() {
        
    }
}
class rContentIntroduction: NSObject,HandyJSON {
    var rIntroduction:String?
    required override init() {
        
    }
}
class rContentPParam: NSObject,HandyJSON {
    var rPParamName:String?
    var rPParamNum:String?
    required override init() {
        
    }
}
class rContentPicture: NSObject,HandyJSON {
    var rPicture:String?
    var rPictureURL:String?
    required override init() {
        
    }
}
class rcontentAxis: NSObject,HandyJSON {
    var rAxis:Array<rAxis> = Array<rAxis>()
    var rAxisName:String?
    required override init() {
        
    }
}
class rAxis: NSObject,HandyJSON {
    var isSelected:String?
    var rAxisContent:String?
    required override init() {
        
    }
}
