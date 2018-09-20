//
//  JDXCategoryViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXCategoryViewController: JDXBaseViewController{
    let recommendInfo = JDXRecommendGetInfo()
    var brandDataSource = Array<JDXRecommendGetInfo>()
    var cateGoryDataSource = Array<JDXRecommendGetInfo>()
    var brandView:JDXCategoryItemView = JDXCategoryItemView()
    var categoryView:JDXCategoryItemView = JDXCategoryItemView()
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.brandView)
        self.view.addSubview(self.categoryView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        loadData()
    }
    func loadData() {
        QMUITips.showLoading("加载中", in: self.view!)
        let queue = DispatchQueue(label: "JDXCategoryViewController")
        let group = DispatchGroup()
        weak var weakSelf =  self
        //获取 品牌
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.recommendInfo.loadBrandData(complectedCallback: { (result) in
                weakSelf?.brandDataSource = result
                sema.signal()
            }, failCallback: {
                sema.signal()
            })
            sema.wait()
        }
        //获取 类目
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.recommendInfo.loadCategoryData(complectedCallback: { (result) in
                weakSelf?.cateGoryDataSource = result
                sema.signal()
            }, failCallback: {
                sema.signal()
            })
            sema.wait()
        }
        //全部调用完成后回到主线程,再更新UI
        group.notify(queue: DispatchQueue.main, execute: {[weak self] in
            QMUITips.hideAllTips(in: self!.view!)
            weakSelf?.brandView.setData(data: (weakSelf?.brandDataSource)!)
            weakSelf?.brandView.titleStr = "品牌"
            weakSelf?.categoryView.setData(data: (weakSelf?.cateGoryDataSource)!)
            weakSelf?.categoryView.titleStr = "分类"
        })
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.brandView.snp.makeConstraints { (make) in
            make.top.equalTo(scaleWidth(width: 10.0))
            make.left.right.equalToSuperview()
            make.height.equalTo(scaleWidth(width: 165.0))
        }
        
        self.categoryView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.brandView.snp.bottom)
            make.height.equalTo(scaleWidth(width: 165.0))
        }
    }
}
