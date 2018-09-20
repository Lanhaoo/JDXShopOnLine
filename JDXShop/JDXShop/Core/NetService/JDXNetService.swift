//
//  JDXNetService.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import Reachability
class JDXNetService {
    
    /// 最基础的网络请求 返回的数据需要再 手动解析成 目标数据模型
    class public func startRequest(url:String!,
                                   params:[String:Any]?,
                                   finishedCallback:@escaping (_ result : NetResponse) -> (),
                                   failCallback:@escaping () -> ()){
        if getNetWorksStatus(){
            Alamofire.request(JDXApiDefine.domain+url,
                              method:HTTPMethod.post,
                              parameters: params,
                              encoding: JSONEncoding.default,
                              headers: netServiceHeaders).responseData { (response) in
                                switch response.result {
                                case .success(let value):
                                    do{
                                        let json = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                                        let dic = json as! [String:Any]
                                        if let object = NetResponse.deserialize(from: dic){
                                            if object.Code == "200"{
                                                finishedCallback(object)
                                            }else{
                                                if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                                    QMUITips.showError(object.Messige ?? "暂无数据", in: view, hideAfterDelay: 2.0)
                                                }
                                                failCallback()
                                            }
                                        }
                                    }catch _ {
                                        //执行到这里 说明服务器异常
                                        if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                            QMUITips.showError("服务器异常", in: view, hideAfterDelay: 2.0)
                                        }
                                        failCallback()
                                    }
                                case .failure(let error):
                                    failCallback()
                                    if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                        QMUITips.showError("服务器连接失败", in: view, hideAfterDelay: 2.0)
                                    }
                                    print(error.localizedDescription)
                                }
            }
        }else{
            failCallback()
            if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                QMUITips.showError("网络未连接", in: view, hideAfterDelay: 2.0)
            }
        }
    }
    
    /*
     下面两种请求的方法会自动解析成功目标数据源 再返回，外界可以直接使用返回的数据
     */
    /// 适用于返回数据是单个模型的 网络请求 如服务器返回的数据格式:data:{key:value}
    class public func requestForCustomModelResult<T:HandyJSON>(url:String!,
                                                               params:[String:Any]?,
                                                               resultModel:T,
                                                               finishedCallback:@escaping (_ result : T) -> (),
                                                               failCallback:@escaping () -> ()){
        
        
        if getNetWorksStatus() {
            Alamofire.request(JDXApiDefine.domain+url,
                              method: HTTPMethod.post,
                              parameters: params,
                              encoding: JSONEncoding.default,
                              headers: netServiceHeaders).responseData { (response) in
                                switch response.result{
                                case .success(let value):
                                    LHCacheManager.cacheManager.loadCacheDir()
                                    do{
                                        let resultJson = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                                        let resultDict = resultJson as! [String:Any]
                                        if let resultObject = NetResponse.deserialize(from: resultDict){
                                            //根据与服务端 约定好的code来判断
                                            if resultObject.Code == "200"{
                                                //自动解析成目标数据 源
                                                if let actualData = resultObject.data as? [String:Any]?{
                                                    print(actualData ?? " ")
                                                    //缓存原始数据
                                                    LHCacheManager.cacheManager.setObject(value: actualData as AnyObject, key: getCacheKey(params: params, url: url))
                                                    if let ob = T.deserialize(from: actualData){
                                                        finishedCallback(ob)
                                                    }
                                                }
                                            }else{
                                                //服务器端返回 错误
                                                failCallback()
                                                if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                                    QMUITips.showError(resultObject.Messige ?? "暂无数据", in: view, hideAfterDelay: 2.0)
                                                }
                                            }
                                        }
                                    }catch _{
                                        //执行到这里 说明服务器异常
                                        failCallback()
                                        if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                            QMUITips.showError("服务器异常", in: view, hideAfterDelay: 2.0)
                                        }
                                    }
                                case .failure(_):
                                    failCallback()
                                    if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                        QMUITips.showError("服务器连接失败", in: view, hideAfterDelay: 2.0)
                                    }
                                }
            }
        }else{
            failCallback()
            if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                QMUITips.showError("网络未连接", in: view, hideAfterDelay: 2.0)
            }
            //从缓存中拿数据
            DispatchQueue.main.async {
                if let actualData = LHCacheManager.cacheManager.object(key: getCacheKey(params: params, url: url)) as? [String:Any]?{
                    //缓存原始数据
                    if let ob = T.deserialize(from: actualData){
                        finishedCallback(ob)
                    }
                }
            }
        }
    }
    /// 适用于返回数据是数组类型的 网络请求 如服务器返回的数据格式:data:{[{key:value},{key:value}]}
    class public func requestForArrayResult<T:HandyJSON>(url:String!,
                                                         params:[String:Any]?,
                                                         finishedCallback:@escaping (_ result :Array<T>) -> (),
                                                         failCallback:@escaping () -> ()){
        
        if getNetWorksStatus() {
            Alamofire.request(JDXApiDefine.domain+url,
                              method: HTTPMethod.post,
                              parameters: params,
                              encoding: JSONEncoding.default,
                              headers: netServiceHeaders).responseData { (response) in
                                switch response.result{
                                case .success(let value):
                                LHCacheManager.cacheManager.loadCacheDir()
                                do{
                                    let resultJson = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                                    let resultDict = resultJson as! [String:Any]
                                    if let resultObject = NetResponse.deserialize(from: resultDict){
                                        //根据与服务端 约定好的code来判断
                                        if resultObject.Code == "200"{
                                            //自动解析成目标数据 源
                                            if let actualData = resultObject.data as? Array<Any>{
                                                //缓存原始数据
                                                LHCacheManager.cacheManager.setObject(value: actualData as AnyObject, key: getCacheKey(params: params, url: url))

                                                var resultArr = Array<T>()
                                                for item in actualData {
                                                    if let ob = T.deserialize(from: item as? Dictionary){
                                                        resultArr.append(ob)
                                                    }else{
                                                        //转model失败 打印一下服务端返回的原始数据
                                                        print("数据转换失败,服务端返回的数据:"+"\(item)")
                                                    }
                                                }
                                                finishedCallback(resultArr)
                                            }

                                        }else{
                                            //服务器端返回 错误
                                            failCallback()
                                            if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                                QMUITips.showError(resultObject.Messige ?? "暂无数据", in: view, hideAfterDelay: 2.0)
                                            }
                                        }
                                    }
                                }catch _{
                                    //执行到这里 说明服务器异常
                                    failCallback()
                                    if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                        QMUITips.showError("服务器异常", in: view, hideAfterDelay: 2.0)
                                    }
                                }
                                case .failure(_):
                                    failCallback()
                                    if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                        QMUITips.showError("服务器连接失败", in: view, hideAfterDelay: 2.0)
                                    }
                                }
            }
        }else{
            failCallback()
            if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                QMUITips.showError("网络未连接", in: view, hideAfterDelay: 2.0)
            }
            //从缓存中拿数据
            DispatchQueue.main.async {
                if let actualData = LHCacheManager.cacheManager.object(key: getCacheKey(params: params, url: url)) as? Array<Any>{
                    var resultArr = Array<T>()
                    for item in actualData {
                        if let ob = T.deserialize(from: item as? Dictionary){
                            resultArr.append(ob)
                        }else{
                            //转model失败 打印一下服务端返回的原始数据
                            print("数据转换失败,服务端返回的数据:"+"\(item)")
                        }
                    }
                    finishedCallback(resultArr)
                }
            }
        }
    }
}


/// 把请求的参数 和连接 拼接成缓存 对应的key
func getCacheKey(params:[String:Any]?,url:String)->String{
    var keyStr = ""
    if let actualParams = params {
        
        for (key, value) in actualParams
        {
            let keyValue = "\(key) : \(value)"
            keyStr.append(keyValue)
        }
    }
    keyStr.append(url)
    return keyStr
}

func getNetWorksStatus() -> Bool {
    switch Reachability.forInternetConnection().currentReachabilityStatus() {
    case NetworkStatus.NotReachable:
        return false
    default:
        return true
    }
}
//网络请求 返回的数据
class NetResponse: HandyJSON {
    var Code:String?
    var Messige:String?
    var data:Any?
    required init() {}
}

