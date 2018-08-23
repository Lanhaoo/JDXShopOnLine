//
//  JDXTableParseDataService.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import HandyJSON
class JDXTableParseDataService<T:HandyJSON> : JDXTableNetService {
    /// 自动解析成模型
    ///
    /// - Parameter data: 返回解析成功的模型数组
    override func fetchDataSuccess(data:AnyObject?){
        // 自动解析数据
        if let actualData = data as? Array<Any>{
            var dataRecords:Array<Any> = Array<Any>()
            for item in actualData{
                if let object = T.deserialize(from: item as? Dictionary){
                    dataRecords.append(object)
                }
            }
            if let actualDelegate = self.delegate{
                actualDelegate.requestSuccess(result: dataRecords as AnyObject)
            }
        }else{
            if let actualData = data{
                print(actualData)
                if let object = T.deserialize(from: actualData as? Dictionary){
                    if let actualDelegate = self.delegate{
                        actualDelegate.requestSuccess(result: object as AnyObject)
                    }
                }
            }
        }
    }
}
