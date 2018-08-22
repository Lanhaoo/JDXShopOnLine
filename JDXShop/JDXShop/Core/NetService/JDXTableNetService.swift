//
//  JDXTableNetService.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//
/*
 专门处理表格网络数据请求
 */
import Foundation
import Alamofire
import Reachability
public class JDXTableNetService:NSObject{
    var delegate:JDXTableNetServiceProtocal?
    var requestUrl:String?
    var params:[String:Any]?
    internal func createService(url:String,
                           params:[String:Any],
                           delegate:JDXTableNetServiceProtocal){
        self.requestUrl = url
        self.params = params
        self.delegate = delegate
    }
    func startExcute() {
        if self.getNetWorksStatus(){
            Alamofire.request(checkUrl(), method: .post, parameters: params, encoding: JSONEncoding.default, headers: netServiceHeaders).responseData { (response) in
                switch response.result {
                case .success(let value):
                    do{
                        let json = try JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                        let dic = json as! [String:Any]
                        if let object = NetResponse.deserialize(from: dic){
                            if object.Code == "200" {
                                self.fetchDataSuccess(data: object.data as AnyObject)
                            }else{
                                if let errMsg = object.Messige{
                                    if let actualDelegate = self.delegate{
                                        actualDelegate.requestFail(errorMsg: errMsg)
                                    }
                                }
                            }
                        }
                    }catch _ {
                        //执行到这里 是因为没有连接到服务器 
                        if let actualDelegate = self.delegate{
                            actualDelegate.serviceLinkFail()
                        }
                    }
                case .failure( _):
                    if let actualDelegate = self.delegate{
                        actualDelegate.serviceLinkFail()
                    }
                }
            }
        }else{
            if let actualDelegate = self.delegate{
                actualDelegate.interNetFail()
            }
        }
    }
    
    /// 解析数据成功
    ///
    /// - Parameter data: 返回数据集
    func fetchDataSuccess(data:AnyObject?) {
        if let actualData = data as? Array<Any>{
            if let actualDelegate = self.delegate{
                actualDelegate.requestSuccess(result: actualData as Array<AnyObject>)
            }
        }
    }
    
    func checkUrl() -> String {
        var resultUrl:String! = ""
        if let url = self.requestUrl {
            if !url.hasPrefix("O"){
                resultUrl = JDXApiDefine.domain + url
            }else{
                resultUrl = JDXApiDefine.domain + url + "O"
            }
        }
        return resultUrl
    }
    
    func getNetWorksStatus() -> Bool {
        switch Reachability.forInternetConnection().currentReachabilityStatus() {
        case NetworkStatus.NotReachable:
            return false
        default:
            return true
        }
    }
    
}
