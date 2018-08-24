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
        header?.setTitle("下拉即可刷新", for: MJRefreshState.idle)
        header?.setTitle("松开即可刷新", for: MJRefreshState.pulling)
        header?.setTitle("玩儿命加载中", for: MJRefreshState.refreshing)
        header?.lastUpdatedTimeLabel.isHidden = true
        self.mj_header = header
    }
    
    public func addFooterRefresh(complectedCallback:@escaping () -> ()){
        let footer = MJRefreshBackNormalFooter.init(refreshingBlock: complectedCallback)
        footer?.stateLabel.isHidden = false
        footer?.setTitle("上拉获取更多数据", for: MJRefreshState.idle)
        footer?.setTitle("没有更多数据了", for: MJRefreshState.noMoreData)
        self.mj_footer = footer
    }
    
    //以下两个方法只适用于 商品详情页 上下拉刷新 类似于京东 详情页 其他页面不需要使用
    public func addHeaderRefreshForGoodsDetailView(complectedCallback:@escaping () -> ()){
        let header = MJRefreshNormalHeader.init(refreshingBlock: complectedCallback)
        header?.setTitle("下拉查看商品详情", for: MJRefreshState.idle)
        header?.setTitle("松开即可查看商品详情", for: MJRefreshState.pulling)
        header?.setTitle("正在获取商品详情", for: MJRefreshState.refreshing)
        header?.lastUpdatedTimeLabel.isHidden = true
        self.mj_header = header
    }
    public func addFooterRefreshForGoodsDetailView(complectedCallback:@escaping () -> ()){
        let footer = MJRefreshBackNormalFooter.init(refreshingBlock: complectedCallback)
        footer?.stateLabel.isHidden = false
        footer?.setTitle("上拉查看商品信息", for: MJRefreshState.idle)
        footer?.setTitle("松开即可查看商品信息", for: MJRefreshState.pulling)
        footer?.setTitle("正在获取商品信息", for: MJRefreshState.refreshing)
        footer?.setTitle("上拉查看商品信息", for: MJRefreshState.noMoreData)
        self.mj_footer = footer
    }
    
    
}
