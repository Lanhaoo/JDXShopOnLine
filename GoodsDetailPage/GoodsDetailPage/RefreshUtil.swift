//
//  RefreshUtil.swift
//  JDXShop
//
//  Created by lanhao on 2018/8/20.
//  Copyright © 2018年 lanhao. All rights reserved.
//

/*
 封装上下拉刷新 控件
 */
import Foundation
struct PrivateKey {
    static let pageKey = UnsafeRawPointer.init(bitPattern: "pageKey".hashValue)
    static let pageSizeKey = UnsafeRawPointer.init(bitPattern: "pageSizeKey".hashValue)
}
extension UIScrollView{
    //添加属性
    var currentPage:Int!{
        set {
            objc_setAssociatedObject(self, PrivateKey.pageKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, PrivateKey.pageKey!) as! Int
        }
    }
    var pageSize:Int!{
        set {
            objc_setAssociatedObject(self, PrivateKey.pageSizeKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, PrivateKey.pageSizeKey!) as! Int
        }
    }
    public func addHeaderRefresh(complectedCallback:@escaping () -> ()){
        let header = MJRefreshNormalHeader.init(refreshingBlock: complectedCallback)
        header?.setTitle("下拉显示商品信息", for: MJRefreshState.idle)
        header?.setTitle("松开即可显示商品信息", for: MJRefreshState.pulling)
        header?.setTitle("正在加载商品信息", for: MJRefreshState.refreshing)
        header?.lastUpdatedTimeLabel.isHidden = true
        self.mj_header = header
    }
    
    public func addFooterRefresh(complectedCallback:@escaping () -> ()){
        let footer = MJRefreshBackNormalFooter.init(refreshingBlock: complectedCallback)
        footer?.stateLabel.isHidden = false
        footer?.setTitle("上拉显示商品详情", for: MJRefreshState.idle)
        footer?.setTitle("松开即可显示商品详情", for: MJRefreshState.pulling)
        footer?.setTitle("正在加载商品详情", for: MJRefreshState.refreshing)
        footer?.setTitle("", for: MJRefreshState.noMoreData)
        self.mj_footer = footer
    }
    
    
}
