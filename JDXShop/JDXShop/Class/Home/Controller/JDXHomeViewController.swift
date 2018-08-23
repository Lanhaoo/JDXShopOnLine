//
//  JDXHomeViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXHomeViewController: JDXBaseCollectionViewController,JDXLimitSaleViewProtocol {
    let productModel = JDXHomePageProductInfo()
    override func loadView() {
        super.loadView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barTintColor = UIColor.qmui_color(withHexString: "#ffe53a")
//        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.qmui_color(withHexString: "#ffe53a"))
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.scrollViewDidScroll(self.collectionView!)
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
    override func loadData() {
        productModel.loadProductData(page: self.page, pageSize: self.pageSize, complectedCallback: { (result) in
            for item in result{
                self.dataRecords?.append(item)
            }
            self.collectionView?.reloadData()
        }) {

        }
    }
    override func getCellData(indexPath: NSIndexPath) -> AnyObject {
        return self.dataRecords![indexPath.row] as AnyObject
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
        //        let cellItem = super.getCellData(indexPath: indexPath as NSIndexPath)
        let detailPage = JDXProductDetailController.init(style: UITableViewStyle.plain)
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    //设置显示头视图
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView:UICollectionReusableView?
        if indexPath.section == 0 {
            let banner = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomePageBannerView", for: indexPath) as! HomePageBannerView
            return banner
        }
        if indexPath.section == 1 {
            let limitSaleView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXLimitSaleView", for: indexPath) as! JDXLimitSaleView
            limitSaleView.delegate = self
            return limitSaleView
        }
        if indexPath.section == 2 {
            let kindMenuView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXKindMenuView", for: indexPath)
            return kindMenuView
        }
        if indexPath.section == 3 {
            let brandView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXBrandView", for: indexPath)
            return brandView
        }
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
        return headerView!
    }
    //设置头视图 的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var size : CGSize = CGSize.init(width: 0, height: 0)
        if section == 0 {
            size = CGSize.init(width: kScreen_Width, height: scaleHeight(height: 189.0))
        }
        if section == 1 {
            size = CGSize.init(width: kScreen_Width, height: scaleHeight(height: 254.0))
        }
        if section == 2 {
            size = CGSize.init(width: kScreen_Width, height: scaleHeight(height: 206.0))
        }
        if section == 3{
            size = CGSize.init(width: kScreen_Width, height: scaleHeight(height: 290.0))
        }
        return size
    }
    
    //定义每个item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: scaleWidth(width:187.0), height: scaleHeight(height:245.0))
    }
    //定义item之间的水平间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return scaleWidth(width: 1)
    }
    //定义item之间的垂直间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return scaleHeight(height: 1.0)
    }
}
