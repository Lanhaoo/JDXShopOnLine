//
//  JDXCustomerASGetInfo.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/11.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXCustomerASGetInfo: JDXBaseModel {
    var rCID:String?
    var rCName:String?
    var rCNum:String?
    var rCPhoto:String?
    var rCPhotoURL:String?
    var rContentAsset:Array<rContentAsset> = [] //优惠券 数据源
    var rContentItem:Array<rContentAsset> = [] //订单数据源
    var rContentOrder:Array<rContentOrder> = [] //table cell数据源
}
extension JDXCustomerASGetInfo{
    func loadProfileInfo(complectedCallback:@escaping(_ result:JDXCustomerASGetInfo)->(),failCallback:()->()) {
        JDXNetService.requestForCustomModelResult(url: JDXApiDefine.customerASGetO,
                                                  params: nil,
                                                  resultModel: JDXCustomerASGetInfo(),
                                                  finishedCallback: { (result) in
            complectedCallback(result)
        }) {
            
        }
    }
}
class rContentAsset: JDXBaseModel {
    var rCItem:String?
    var rCItemText:String?
}
class rContentOrder: JDXBaseModel {
    var rCItem:String?
    var rCItemPicture:String?
    var rCItemText:String?
}
