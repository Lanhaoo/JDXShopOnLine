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
                                   params:[String:Any],
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
    /// 适用于返回数据是单个模型的 网络请求
    class public func autoParseModelRequest<T:HandyJSON>(url:String!,
                                   params:[String:Any]?,
                                   resultModel:T,
                                   finishedCallback:@escaping (_ result : T) -> (),
                                   failCallback:@escaping () -> ()){
        
        
        
        
    }
    
    /// 适用于返回数据是数组类型的 网络请求
    class public func autoParseListModelRequest<T:HandyJSON>(url:String!,
                                                         params:[String:Any]?,
                                                         resultModel:T,
                                                         finishedCallback:@escaping (_ result :Array<T>) -> (),
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
                                                //自动解析成目标数据 源
                                                if let actualData = object.data as? Array<Any>{
                                                    var resultArr = Array<T>()
                                                    for item in actualData {
                                                        
                                                        if let ob = T.deserialize(from: item as? Dictionary){
                                                            resultArr.append(ob)
                                                        }
                                                        
                                                    }
                                                    finishedCallback(resultArr)
                                                    
                                                }
                                                
                                            
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

