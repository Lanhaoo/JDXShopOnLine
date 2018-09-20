//
//  JDXBaseNetOperate.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/6.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
protocol NetworkAPIConvertable {
    var host:String {get}
    var path:String {get}
    var method:RequestMethod{get}
    var requestEncoding:RequestEncoding{get}
    var requestParams:[String:Any]?{get}
}
enum RequestEncoding{
    case json, propertyList, url
}
enum RequestMethod{
    case get, post, delete, put
}
private extension RequestMethod{
    func toAlamofireMethod()->HTTPMethod{
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        case .put:
            return .put
        }
    }
}
private extension RequestEncoding{
    func toAlamofireEncoding()->ParameterEncoding{
        switch self {
        case .json:
            return JSONEncoding.default
        case .propertyList:
            return PropertyListEncoding()
        case .url:
            return URLEncoding()
        }
    }
}
struct APIRouter<T:HandyJSON>{
    
    enum ResponseResult{
        case succeed(value:T)
        case error(error:Error)
    }
    static func request(api:NetworkAPIConvertable,completionHandler:@escaping (ResponseResult) -> Void){
        
        let requestPath = api.host + api.path
        
        Alamofire.request(requestPath,
                          method: api.method.toAlamofireMethod(),
                          parameters: api.requestParams,
                          encoding: api.requestEncoding.toAlamofireEncoding(),
                          headers: netServiceHeaders).responseData { (response) in
                            
            switch response.result {
                
            case .success(let value):
                do{
                    let json = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                    let dic = json as! [String:Any]
                    if let object = NetResponse.deserialize(from: dic){
                        if object.Code == "200"{
                            if let actualData = object.data as? [String:Any]?{
                                if let ob = T.deserialize(from: actualData){
                                    completionHandler(ResponseResult.succeed(value: ob))
                                }
                            }
                        }else{
                            if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                                QMUITips.showError(object.Messige ?? "暂无数据", in: view, hideAfterDelay: 2.0)
                            }
                        }
                    }
                }catch _ {
                    //执行到这里 说明服务器异常
                    if let view = UIApplication.shared.keyWindow?.rootViewController?.view{
                        QMUITips.showError("服务器异常", in: view, hideAfterDelay: 2.0)
                    }
                }
            case .failure(let error):
                completionHandler(ResponseResult.error(error: error))
            }
        }
    }
}

//测试用例
enum NetworkService{
    case JDXCustomerASGet()
}
extension NetworkService:NetworkAPIConvertable{
    var host: String {
        return JDXApiDefine.domain
    }
    var path: String {
        switch self {
        case .JDXCustomerASGet:
            return JDXApiDefine.customerASGetO
        }
    }
    var method: RequestMethod {
        switch self {
        case .JDXCustomerASGet:
            return .post
        }
    }
    var requestEncoding: RequestEncoding {
        switch self {
        case .JDXCustomerASGet:
            return .json
        }
    }
    var requestParams: [String : Any]? {
        switch self {
        case .JDXCustomerASGet:
            return nil
        }
    }
    
}

