//
//  JDXTableNetServiceProtocal.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import Foundation

protocol JDXTableNetServiceProtocal {
    //请求成功 返回数据集
    func requestSuccess(result:AnyObject?)
    //请求失败
    func requestFail(errorMsg:String?)
    //网络未连接
    func interNetFail()
    //服务器连接失败
    func serviceLinkFail()
}
