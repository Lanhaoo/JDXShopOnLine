//
//  JDXTimeLimitInfo.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/23.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class JDXTimeLimitInfo: NSObject,HandyJSON {
    var rContentAD:Array<JDXTimeLimitRowData>? = Array<JDXTimeLimitRowData>()
    var rContentSearch:String?
    var sFinishTime:String?
    var sLatitude:String?
    var sLongitude:String?
    var sOrder:String?
    required override init() {
        
    }
}
class JDXTimeLimitRowData:  NSObject,HandyJSON {
    var rADChinese:String?
    var rADEnglish:String?
    var rADPrice:String?
    var rADTitle:String?
    var rDownTime:String?
    var rNum:String?
    var rOpenKind:String?
    var rOpenParam:String?
    var rOrder:String?
    var rPicture:String?
    var rPictureURL:String?
    var rPosition:String?
    var rStatus:String?
    var rTitle:String?
    var rUpTime:String?
    required override init() {
        
    }
}
