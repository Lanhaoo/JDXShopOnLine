//
//  JDXHomeViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXHomeViewController: JDXBaseCollectionViewController,JDXLimitSaleViewProtocol {
    var banner:HomePageBannerView? = nil
    var limitSaleView:JDXLimitSaleView? = nil
    var kindMenuView:JDXKindMenuView? = nil
    var brandView:JDXBrandView? = nil
    let bannerModel = HomePageBanner() // 获取广告的模型层对象
    let productModel = JDXHomePageProductInfo() //获取列表数据的模型层对象
    /**
     品牌数据集
     存放品牌的临时数据集 因为重用机制的原因，第一次进入此页面时brandView可能是空 则brandView赋值失败
     等brandView初始化成功的时候 手动给brandView赋值
     */
    var brandViewDataSource:Array<JDXHomePageProductInfo>? = Array<JDXHomePageProductInfo>()
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.collectionView?.backgroundColor = UIColor.qmui_color(withHexString: "#f5f5f5")
        //注册表头
        self.collectionView?.register(HomePageBannerView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomePageBannerView")
        self.collectionView?.register(JDXLimitSaleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXLimitSaleView")
        self.collectionView?.register(JDXKindMenuView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXKindMenuView")
        self.collectionView?.register(JDXBrandView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXBrandView")
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")
        loadData()
    }
    override func configCell() {
        self.reuseIdentifier = "JDXHomePageProductCell"
        self.collectionView?.register(JDXHomePageProductCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
    /// 获取列表数据的方法
    override func loadData() {
        QMUITips.showLoading("加载中", in: self.view!)
        //任务队列
        let queue = DispatchQueue(label: "JDXHomeViewController")
        //分组
        let group = DispatchGroup()
        weak var weakSelf =  self
        //第一个网络请求 获取 广告
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.bannerModel.fetchBannerData { (result) in
                weakSelf?.banner?.setData(result: result)
                sema.signal()
            }
            sema.wait()
        }
        //第二个网络请求 获取 限时特卖
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.productModel.loadTimeLimitSaleData(complectedCallback: { (result) in
                weakSelf?.limitSaleView?.setTimeLimitViewData(result: result)
                sema.signal()
             }) {
                sema.signal()
             }
             sema.wait()
        }
        //第三个网络请求 获取 尚妆国际
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.productModel.loadInternalLimitSaleData(complectedCallback: { (result) in
                weakSelf?.limitSaleView?.setInternalLimitSaleViewData(result: result)
                sema.signal()
            }) {
                sema.signal()
            }
            sema.wait()
        }
        //第四个网络请求 获取热门分类
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.productModel.loadClassifyData(complectedCallback: { (result) in
                weakSelf?.kindMenuView?.setKindMenuViewData(result:result)
                sema.signal()
            }) {
                sema.signal()
            }
            sema.wait()
        }
        //第五个网络请求 获取品牌
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.productModel.loadBrandData(complectedCallback: { (result) in
                /*
                 因为表格重用机制的原因 这个地方 brandView 可能 为空 会进else分支 所以需要手动保存一下brandView的数据源
                 在创建brandView的时候 手动赋值
                 */
                if let actualView = weakSelf?.brandView{
                    actualView.setBrandViewData(result: result)
                }else{
                    weakSelf?.brandViewDataSource = result
                    print("self.brandView为空")
                }
                sema.signal()
            }) {
                sema.signal()
            }
            sema.wait()
        }
        //第六个网络请求 获取 热门推荐
        queue.async(group: group) {
            let sema = DispatchSemaphore(value: 0)
            self.productModel.loadProductData(page: self.page, pageSize: self.pageSize, complectedCallback: { (result) in
                for item in result{
                    self.dataRecords?.append(item)
                }
                sema.signal()
            }) {
                sema.signal()
            }
            sema.wait()
        }
        //全部调用完成后回到主线程,再更新UI
        group.notify(queue: DispatchQueue.main, execute: {[weak self] in
            QMUITips.hideAllTips(in: self!.view!)
            self?.collectionView?.reloadData()
        })
    }
    override func getCellData(indexPath:NSIndexPath)->AnyObject?{
        if indexPath.section == 4 {
            return self.dataRecords?[indexPath.row] as! JDXHomePageProductInfo
        }
        return nil
    }
}

// MARK: - 实现自定义代理的分类
extension JDXHomeViewController{
    func handleSelectedTimeLimitItem() {
        let timeLimitSalePage = JDXTimeLimitSaleController.init(style: UITableViewStyle.plain)
        self.navigationController?.pushViewController(timeLimitSalePage, animated: true)
    }
    func handleSelectedInternalItem() {
        
    }
}
extension JDXHomeViewController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 4 {
            return (self.dataRecords?.count)!
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellItem = self.getCellData(indexPath: indexPath as NSIndexPath) as! JDXHomePageProductInfo
        let detailPage = JDXProductDetailController()
        if let num = cellItem.rOpenParam {
            detailPage.goodsNum = num
        }
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    //设置显示头视图
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView:UICollectionReusableView?
        if indexPath.section == 0 {
            banner = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomePageBannerView", for: indexPath) as? HomePageBannerView
            return banner!
        }
        if indexPath.section == 1 {
            limitSaleView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXLimitSaleView", for: indexPath) as? JDXLimitSaleView
            limitSaleView?.delegate = self
            return limitSaleView!
        }
        if indexPath.section == 2 {
            kindMenuView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXKindMenuView", for: indexPath) as? JDXKindMenuView
            return kindMenuView!
        }
        if indexPath.section == 3 {
            brandView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXBrandView", for: indexPath) as? JDXBrandView
            if let dataSource = self.brandViewDataSource{
                brandView?.setBrandViewData(result: dataSource)
                //赋值成功 就清空 brandViewDataSource，防止每一次滑动 都赋值 造成页面卡顿
                self.brandViewDataSource = nil
            }
            return brandView!
        }
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
        return headerView!
    }
    //设置头视图 的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var size : CGSize = CGSize.init(width: 0, height: 0)
        if section == 0 {
            size = CGSize.init(width: kScreen_Width, height: scaleWidth(width: 189.0))
        }
        if section == 1 {
            size = CGSize.init(width: kScreen_Width, height: scaleWidth(width: 253.0))
        }
        if section == 2 {
            size = CGSize.init(width: kScreen_Width, height: scaleWidth(width: 206))
        }
        if section == 3{
            size = CGSize.init(width: kScreen_Width, height: scaleWidth(width: 290.0))
        }
        return size
    }
    
    //定义每个item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: scaleWidth(width:187.0), height: scaleWidth(width:245.0))
    }
    //定义item之间的水平间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return scaleWidth(width: 1)
    }
    //定义item之间的垂直间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return scaleWidth(width: 1.0)
    }
}
