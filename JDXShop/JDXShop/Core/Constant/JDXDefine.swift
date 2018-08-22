//
//  JDXDefine.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/20.
//  Copyright © 2018年 3. All rights reserved.
//
/*
 存放常用方法的类
 */
import UIKit
import Foundation
import Alamofire
let kScreen_Width = UIScreen.main.bounds.size.width
let kScreen_Height = UIScreen.main.bounds.size.height
//按照6的尺寸 进行缩放
//缩放后的宽度
func scaleWidth(width:CGFloat)->CGFloat{
    return kScreen_Width * (width/375.0)
}
//缩放后的高度
func scaleHeight(height:CGFloat) -> CGFloat {
    return kScreen_Height * (height / 667.0)
}
//网络请求头
let netServiceHeaders:HTTPHeaders = [
    "DBKey":"88cb975bfe4b850ffb759f47f3e856f2",
    "Token":"pnj7P5AXGPDXNMBH7dGZv2EgkTgj9mX2"
]
//显示网络图片的方法
//func showImage(url:String?){
//    if let actualUrl = url{
//        
//    }
//}
