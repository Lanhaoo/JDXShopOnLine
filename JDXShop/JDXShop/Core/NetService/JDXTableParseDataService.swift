//
//  JDXTableParseDataService.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXTableParseDataService<T:JSONModel> : JDXTableNetService {
    
    /// 自动解析成模型
    ///
    /// - Parameter data: 返回解析成功的模型数组
    override func fetchDataSuccess(data:AnyObject?){
        // 自动解析数据
        if let actualData = data as? Array<Any>{
            var dataRecords:Array<Any> = Array<Any>()
           
            do{
                dataRecords = try T.arrayOfModels(fromDictionaries: actualData, error:()) as! Array<Any>
            }catch(_){
                
            }
           
            
//            for item in actualData{
//                if let object =  T.arrayOfModels(fromDictionaries: item as! [Any], error: ()){
//                    dataRecords.append(object)
//                }
//            }
            if let actualDelegate = self.delegate{
                actualDelegate.requestSuccess(result: dataRecords as Array<AnyObject>)
            }
        }
    }
}
