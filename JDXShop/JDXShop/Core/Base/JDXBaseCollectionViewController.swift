//
//  JDXBaseCollectionViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
class JDXBaseCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var reuseIdentifier:String!
    var page:Int = 1
    var pageSize:Int = 10
    var dataManager = JDXTableDataManager()
    lazy var dataRecords : Array<Any>? = Array<Any>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.backgroundColor = UIColor.white
        jdx_addSubViews()
        configCell()
    }
    //MARK: 子类需要重写的方法
    public func jdx_addSubViews(){
        
    }
    public func clearData(){
        page = 1
        dataRecords?.removeAll()
    }
    //下拉刷新时/页面初始化调用
    public func loadData(){
        
    }
    //上拉刷新时调用
    public func loadMoreData(){
        
    }
    //注册cell
    public func configCell(){
        
    }
    //获取选中的值
    public func getCellData(indexPath:NSIndexPath)->AnyObject?{
        return nil;
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let arr = self.dataRecords {
            return arr.count
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
}
