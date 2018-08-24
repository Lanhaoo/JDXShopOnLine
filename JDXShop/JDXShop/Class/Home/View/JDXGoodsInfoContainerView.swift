//
//  JDXGoodsInfoContainerView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/24.
//  Copyright © 2018年 3. All rights reserved.
//

/*
 商品详情页
 
 分为上下 两个部分
 
 上 是一个tableview 用来显示商品基本信息
 下 是一个webview 用户显示商品详情
 */
import UIKit
import WebKit
class JDXGoodsInfoContainerView: UIView {
    var bottomScrollView:UIScrollView!
    var topGoodBaseInfoTableView:JDXGoodsInfoTableView!
    var bottomGoodsInfoWebView:WKWebView!
    var goodsNum:String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bottomScrollView = UIScrollView.init(frame: frame)
        self.bottomScrollView.isPagingEnabled = true
        self.bottomScrollView.isScrollEnabled = false
        self.bottomScrollView.showsVerticalScrollIndicator = false
        self.bottomScrollView.contentSize = CGSize.init(width: 0, height: frame.size.height*2)
        self.addSubview(self.bottomScrollView)
        if #available(iOS 11.0, *) {
            self.bottomScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            
        }
        jdx_addSubView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func jdx_addSubView() {
        self.backgroundColor = UIColor.red
        let width = self.frame.size.width
        let height = self.frame.size.height
        topGoodBaseInfoTableView = JDXGoodsInfoTableView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        self.bottomScrollView.addSubview(topGoodBaseInfoTableView)
        
        //bottomGoodsInfoWebView 位于 topGoodBaseInfoTableView 下方
        let webConfiguration = WKWebViewConfiguration()
        self.bottomGoodsInfoWebView = WKWebView.init(frame:CGRect.init(x: 0, y: height, width:width, height: height), configuration: webConfiguration)
        self.bottomGoodsInfoWebView?.load(URLRequest.init(url: URL.init(string: "http://xzgw.jdxiang.cn/doc/API_Doc_XZGW.html")!))
        self.bottomScrollView.addSubview(self.bottomGoodsInfoWebView)
        
        
        //topGoodBaseInfoTableView 添加上下拉刷新控件
        weak var weakself = self
        self.topGoodBaseInfoTableView.tableView?.addHeaderRefresh {
            weakself?.topGoodBaseInfoTableView.tableView!.mj_header.endRefreshing()
        }
        self.topGoodBaseInfoTableView.tableView?.addFooterRefreshForGoodsDetailView  {
            weakself?.bottomScrollView.setContentOffset(CGPoint.init(x: 0, y: height), animated: true)
            weakself?.topGoodBaseInfoTableView.tableView?.mj_footer.endRefreshing()
        }
        self.bottomGoodsInfoWebView.scrollView.addHeaderRefreshForGoodsDetailView {
            weakself?.bottomScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            weakself?.bottomGoodsInfoWebView.scrollView.mj_header.endRefreshing()
        }
        
        
    }
    func setData(data:JDXProductDetailInfo) {
        self.topGoodBaseInfoTableView.updateUI(data: data)
    }
    private func loadData() {
        if let num = self.goodsNum {
            self.topGoodBaseInfoTableView.goodsNum = num
            self.topGoodBaseInfoTableView.loadData()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
