//
//  JDXBaseTableViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//
/*
 表格基础类
 */
import UIKit

class JDXBaseTableViewController: JDXBaseViewController,UITableViewDataSource,UITableViewDelegate,JDXTableNetServiceProtocal{
    var NetService:JDXTableNetService?
    var reuseIdentifier:String!
    var tableView:UITableView?
    var style:UITableViewStyle?
    var currentPage:Int! = 1
    var pageSize:Int! = 10
    var dataRecords:Array<Any> = Array<Any>()
    deinit {
        self.tableView?.delegate = nil
        self.tableView?.dataSource = nil
        if #available(iOS 11, *) {
        }else{
            self.tableView?.removeObserver(self, forKeyPath: "contentInset")
        }
    }
    init(style:UITableViewStyle!){
        super.init(nibName: nil, bundle: nil)
        self.style = style
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initTableView(){
        if self.tableView == nil {
            self.tableView = UITableView.init(frame: self.view.bounds, style: self.style ?? UITableViewStyle.plain)
            self.tableView?.delegate = self;
            self.tableView?.dataSource = self;
            self.tableView?.showsVerticalScrollIndicator = false
            self.tableView?.tableFooterView = UIView()
            self.view.addSubview(self.tableView!)
            if #available(iOS 11, *) {
                self.tableView?.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never;
            }else{
                self.tableView?.addObserver(self, forKeyPath: "contentInset", options: NSKeyValueObservingOptions.old, context: nil)
            }
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentInset" {
            self.handleTableViewContentInsetChangeEvent()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    private func requestData() {
        initNetService()
        if let service = self.NetService{
            service.startExcute()
        }
    }
    /// 子类必须实现的方法！！！！！
    func initNetService() {
        
    }
    ///页面初始化 或者 页面下拉时 推荐手动 掉用此方法
    func loadData() {
        self.showEmptyViewWithLoading()
        clearData()
        requestData()
    }
    /// 页面上拉时 推荐手动 掉用此方法
    func loadMoreData(){
        requestData()
    }
    func clearData() {
        NetService = nil
        currentPage = 1
        self.dataRecords.removeAll()
        self.tableView?.reloadData()
    }
    //重写 列表数据为空的情况 的按钮 点击事件
    override func tableDataReload() {
        self.showEmptyViewWithLoading()
    }
    
    override func viewDidLayoutSubviews() {
        layoutTableView()
        layoutEmptyView()
    }
    func layoutTableView() {
        let isEqual:Bool = self.tableView!.frame.equalTo(self.view.bounds)
        if !isEqual {
            self.tableView?.frame = self.view.bounds
        }
    }
}
extension JDXBaseTableViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataRecords.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:JDXBaseTableViewCell? = nil
        cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as? JDXBaseTableViewCell
        if let actualCell = cell {
            actualCell.setCellData(data: self.getCellData(index: indexPath as NSIndexPath))
        }else{
           cell = self.createTableViewCell()
        }
        return cell!
    }
    func getCellData(index:NSIndexPath) -> AnyObject? {
        if index.row<self.dataRecords.count{
            return self.dataRecords[index.row] as AnyObject
        }
        return nil
    }
    //该方法只作用于iOS11以上, iOS11以下,通过KVO来监听 contentInset
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        if scrollView != self.tableView {
            return
        }
        self.handleTableViewContentInsetChangeEvent()
    }
    
    /// 创建cell的方法
    func createTableViewCell() -> JDXBaseTableViewCell {
        let cell = JDXBaseTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: self.reuseIdentifier)
        return cell
    }
}

extension JDXBaseTableViewController{
    func requestSuccess(result: Array<AnyObject>?) {
        self.hideEmptyView()
        NetService = nil
        if let actualArray = result {
            print(actualArray)
           self.dataRecords = self.dataRecords+actualArray
            self.tableView?.reloadData()
        }
    }
    
    func requestFail(errorMsg: String?) {
        NetService = nil
        self.showEmptyView(text: "请求失败")
    }
    
    func interNetFail() {
        NetService = nil
        self.showEmptyView(text: "网络未连接")
    }
    
    func serviceLinkFail() {
        NetService = nil
         self.showEmptyView(text: "未能连接到服务器")
    }
    
}
// MARK: - 重写空视图
extension JDXBaseTableViewController{
    override func showEmptyView() {
        hideEmptyView()
        if self.emptyView == nil {
            if let actualTableView = self.tableView{
                self.emptyView = QMUIEmptyView.init(frame: actualTableView.bounds)
                actualTableView.addSubview(self.emptyView!)
            }
        }
    }
    //通过监听 tableView.contentInset 来更改emptyView的布局
    override func layoutEmptyView() {
        if let emptyView = self.emptyView{
            var insets = self.tableView?.contentInset
            if #available(iOS 11, *) {
                if self.tableView?.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentBehavior.never{
                    insets = self.tableView?.adjustedContentInset
                }
            }
            // 当存在 tableHeaderView 时，emptyView 的高度为 tableView 的高度减去 headerView 的高度
            if let headerView = self.tableView?.tableHeaderView{
                emptyView.frame = CGRect.init(x: 0, y: headerView.frame.maxY, width: (self.tableView?.frame.size.width)! - UIEdgeInsetsGetHorizontalValue(insets!), height: (self.tableView?.frame.size.height)! - UIEdgeInsetsGetVerticalValue(insets!))
            }else{
                emptyView.frame = CGRect.init(x: 0, y: 0, width: (self.tableView?.frame.size.width)! - UIEdgeInsetsGetHorizontalValue(insets!), height: (self.tableView?.frame.size.height)! - UIEdgeInsetsGetVerticalValue(insets!))
            }
        }
    }
    //表格的contentsize 只要改变 就更新emptyView的frame
    func handleTableViewContentInsetChangeEvent() {
        if self.isEmptyViewShowing() {
            self.layoutEmptyView()
        }
    }
}
