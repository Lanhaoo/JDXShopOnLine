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
class JDXNetService {
    class public func startRequest(url:String!,
                             params:[String:Any],
                             finishedCallback:@escaping (_ result : NetResponse) -> (),failCallback:@escaping (_ result:NetResponse) -> ()){
        print(params)
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
                            print(object.Messige ?? "没有数据")
                            failCallback(object)
                        }
                    }
                 }catch _ {
                    print("失败")
                 }
            case .failure(let error):
                if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                    QMUITips.showError("网络未连接", in: view, hideAfterDelay: 2.0)
                }
                print(error.localizedDescription)
            }
        }
    }
}

//网络请求 返回的数据
class NetResponse: HandyJSON {
    var Code:String?
    var Messige:String?
    var data:Any?
    required init() {}
}

