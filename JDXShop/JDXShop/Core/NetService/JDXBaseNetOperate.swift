//
//  JDXBaseNetOperate.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/6.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import Alamofire
import Reachability
class JDXBaseNetOperate: NSObject {
    public func createDomain()->String{
        return JDXApiDefine.domain
    }
    public func createRequestUrl()->String?{
        return nil
    }
    public func createRequestParams()->[String:Any]?{
        return nil
    }
    public func createRequestMethod()->HTTPMethod{
        return HTTPMethod.post
    }
    public func createHeader()->HTTPHeaders{
        return ["DBKey":"88cb975bfe4b850ffb759f47f3e856f2",
                "Token":"pnj7P5AXGPDXNMBH7dGZv2EgkTgj9mX2"]
    }
    public func startExcute(){
        if self.createRequestUrl() == nil {
            return
        }
        Alamofire.request(self.createDomain()+self.createRequestUrl()!, method: self.createRequestMethod(), parameters: self.createRequestParams(), encoding: JSONEncoding.default, headers: self.createHeader()).responseData { (response) in
            switch response.result {
            case .success(let value):
                do{
                    let json = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                    let dic = json as! [String:Any]
                    if let object = NetResponse.deserialize(from: dic){
                        if object.Code == "200" {
                            self.requestSuccess(result: object)
                        }else{
//                            if let errMsg = object.Messige{
//
//                            }
                            self.requestFail(error: object)
                        }
                    }
                }catch _ {
                    //执行到这里 是因为没有连接到服务器
                    self.requestFail(error: nil)
                }
            case .failure( _):
                self.requestFail(error: nil)
            }
        }
        
    }
    public func requestSuccess(result:AnyObject?){
        
    }
    
    public func requestFail(error:AnyObject?){
        
    }
    
    public func interNetFail(){
        
    }
    
    
}
