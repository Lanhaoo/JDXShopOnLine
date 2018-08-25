//
//  JDXProductDetailController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXProductDetailController: JDXBaseViewController {
    var productDetailInfo:JDXProductDetailInfo!
    var goodsNum:String? // 商品编号
    /// 底部的滚动图
    var bottomScrollView:UIScrollView?
    //商品详情
    var goodsInfoView:JDXGoodsInfoContainerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //解决 滚动图 向下偏移的bug
        setTableViewContentInset()
    }
    private func setTableViewContentInset(){
        //这段代码的作用是 当设置完当前导航栏不透明的时候 界面坐标 依旧从（0，0）开始计算
        /*
         系统默认是如果当前 导航栏被设置为 不透明，界面坐标 从（0，导航栏+状态栏的高度）开始计算
         会造成界面整体向下偏移 导航栏+状态栏的高度
         */
        if self.navigationController?.navigationBar.isTranslucent == false {
            self.extendedLayoutIncludesOpaqueBars = true;
        }
    }
    override func jdx_addSubViews() {
        self.view.backgroundColor = UIColor.cyan
        self.view.addSubview(UIView())
        self.bottomScrollView = UIScrollView.init(frame: self.view.bounds)
        self.bottomScrollView?.isPagingEnabled = true
        self.bottomScrollView?.bounces = false
        self.view.addSubview(self.bottomScrollView!)
        self.bottomScrollView!.contentSize = CGSize.init(width: kScreen_Width * 3, height: 0)
        
        self.goodsInfoView = JDXGoodsInfoContainerView.init(frame: CGRect.init(x: 0, y: 0, width: self.bottomScrollView!.frame.size.width, height: self.bottomScrollView!.frame.size.height))
        self.bottomScrollView?.addSubview(self.goodsInfoView!)
        
        if let num = self.goodsNum {
            self.goodsInfoView!.goodsNum = num
            QMUITips.showLoading("加载中", in: self.view)
            JDXNetService.startRequest(url: JDXApiDefine.productDetailGet,params:["sPDNum":num,"sShopNum":defaultShopNum],finishedCallback: { (result) in
                QMUITips.hideAllTips(in: self.view)
                print(result.data)
                if let actualData = JDXProductDetailInfo.deserialize(from: result.data as? Dictionary){
                    self.productDetailInfo = actualData
                    self.goodsInfoView!.setData(data: self.productDetailInfo!)
                }
                
            }) {
                QMUITips.hideAllTips(in: self.view)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        self.bottomScrollView!.frame = self.view.frame
        self.goodsInfoView!.frame = CGRect.init(x: 0, y: 0, width: self.bottomScrollView!.frame.size.width, height: self.bottomScrollView!.frame.size.height)
    }
}
