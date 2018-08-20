//
//  JDXHomeViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXHomeViewController: JDXBaseCollectionViewController {
    let productModel = JDXHomePageProductInfo()
//    let fpsLabel:YYFPSLabel = {
//        var label = YYFPSLabel.init(frame: CGRect.init(x: 10, y: 10, width: 60, height: 30))
//        return label
//    }()
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.qmui_color(withHexString: "#f5f5f5")
        //注册表头
        self.collectionView?.register(HomePageBannerView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomePageBannerView")
        self.collectionView?.register(JDXLimitSaleView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXLimitSaleView")
        self.collectionView?.register(JDXKindMenuView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXKindMenuView")
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "UICollectionReusableView")
        loadData()
        self.collectionView?.addHeaderRefresh {
          
        }
        self.collectionView?.addFooterRefresh {
            
        }
        
    }
    override func jdx_addSubViews() {
//        let window = UIApplication.shared.keyWindow
//        window?.addSubview(self.fpsLabel)
    }
    override func configCell() {
        self.reuseIdentifier = "JDXHomePageProductCell"
        self.collectionView?.register(JDXHomePageProductCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    override func loadData() {
        productModel.loadProductData(page: self.collectionView!.currentPage, pageSize: self.collectionView!.pageSize, complectedCallback: { (result) in
            for item in result{
                self.dataRecords?.append(item)
            }
            self.collectionView?.reloadData()
        }) {
        
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3 {
            return (self.dataRecords?.count)!
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell:JDXBaseCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? JDXBaseCollectionViewCell
        if  let actual = cell {
            actual.setCellData(data: getCellData(indexPath: indexPath as NSIndexPath) as AnyObject)
        }
        return cell!
    }
    //设置显示头视图
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView:UICollectionReusableView?
        if indexPath.section == 0 {
            let banner = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomePageBannerView", for: indexPath) as! HomePageBannerView
            return banner
        }
        if indexPath.section == 1 {
            let limitSaleView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXLimitSaleView", for: indexPath)
            return limitSaleView
        }
        if indexPath.section == 2 {
            let kindMenuView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "JDXKindMenuView", for: indexPath)
            return kindMenuView
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
            size = CGSize.init(width: kScreen_Width, height: scaleHeight(height: 253.0))
        }
        if section == 2 {
            size = CGSize.init(width: kScreen_Width, height: scaleHeight(height: 206.0))
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
