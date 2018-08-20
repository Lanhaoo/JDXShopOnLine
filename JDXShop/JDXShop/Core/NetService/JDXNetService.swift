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
class JDXNetService{
    public static let headers:HTTPHeaders = [
        "DBKey":"88cb975bfe4b850ffb759f47f3e856f2",
        "Token":"pnj7P5AXGPDXNMBH7dGZv2EgkTgj9mX2"
    ]
    class func startRequest(url:String!,
                             params:[String:Any],
                             finishedCallback:@escaping (_ result : NetResponse) -> (),
                             failCallback:@escaping (_ result:AnyObject) -> ()){
        Alamofire.request(JDXApiDefine.domain+url,
                          method:.post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                do{
                    let json = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                    let dic = json as! [String:Any]
                    if let object = NetResponse.deserialize(from: dic){
                        finishedCallback(object)
                    }
                 }catch _ {
                    print("失败")
                 }
            case .failure(let error):
                failCallback(error as AnyObject)
                print(error.localizedDescription)
            }
        }
    }
}

//网络请求 返回的数据
class NetResponse: HandyJSON {
    var Code:String?
    var Messige:String?
    var data:AnyObject?
    required init() {}
}

