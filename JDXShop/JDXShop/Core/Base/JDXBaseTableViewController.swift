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
/// 当前表格获取数据的方式
enum TABLE_CURRENTLOADDATA_ACTION{
    case normal   ///常规
    case loadData ///下拉刷新
    case loadMoreData /// 上拉刷新
}
import UIKit
class JDXBaseTableViewController: JDXBaseViewController,UITableViewDataSource,UITableViewDelegate,JDXTableNetServiceProtocal{
    var NetService:JDXTableNetService?
    var reuseIdentifier:String! //cell的重用标识符 页面初始化的时候 必须设置
    var tableView:UITableView?
    var style:UITableViewStyle?
    var currentPage:Int = 1
    var pageSize:Int = 10
    var dataRecords:Array<Any> = Array<Any>() //数据集
    var loadDataAction:TABLE_CURRENTLOADDATA_ACTION? /// 当前表格获取数据的方式
    deinit {
        print("释放了")
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
        initTableView()
        super.viewDidLoad()
    }
    /// 子类必须实现的方法！！！！！
    func initNetService() {
        
    }
    /// 获取数据时 显示loadingView
    func loadDataWithEmptyLoadingView() {
        self.loadDataAction = TABLE_CURRENTLOADDATA_ACTION.normal
        //先显示loading
        self.showEmptyViewWithLoading()
        currentPage = 1
        requestData()
    }
    /// 列表需要重新加载数据或者下拉的时候 调用此方法
    func loadData() {
        self.loadDataAction = TABLE_CURRENTLOADDATA_ACTION.loadData
        requestData()
    }
    /// 列表需要加载更多数据的时候 调用此方法 常用于上拉刷新
    func loadMoreData(){
        self.loadDataAction = TABLE_CURRENTLOADDATA_ACTION.loadMoreData
        requestData()
    }
    /// 清空列表数据的方法
    func clearData() {
        NetService = nil
        currentPage = 1
        self.dataRecords.removeAll()
        self.tableView?.reloadData()
    }
    /// 列表请求数据的基础方法
    private func requestData() {
        //请求之前先初始化 NetService对象，通过NetService对象 发起网络请求
        //当前子类必须重写 initNetService()函数
        initNetService()
        //程序在这里崩溃，说明当前子类没有重写initNetService()函数，或者没能正确的初始化 NetService对象
        assert(NetService != nil, "请先重写initNetService()函数初始化NetService")
        if let service = self.NetService{
            service.startExcute()
        }
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
    
    
    
    /// 请求成功
    func requestSuccess(result:AnyObject?) {
        endRefreshing()
        self.hideEmptyView()
        showRefresh()
        NetService = nil
        if let actualArray = result as? Array<AnyObject> {
            if let action = self.loadDataAction{
                switch action {
                case .normal:
                    clearData()
                    self.dataRecords = actualArray
                    break
                case .loadData:
                    clearData()
                    self.dataRecords = actualArray
                    break
                case .loadMoreData:
                    self.dataRecords = self.dataRecords+actualArray
                    break
                }
            }
            self.tableView?.reloadData()
            self.currentPage += 1
        }
    }
    /// 请求失败
    func requestFail(errorMsg: String?) {
        endRefreshing()
        NetService = nil
        if self.dataRecords.count<=0 {
            //当页面没有数据的时候 显示 空数据提示页
            self.showNODataEmptyView()
            //隐藏刷新控件
            hideRefresh()
        }
    }
    /// 网络未连接
    func interNetFail() {
        //提示没有网络连接
        QMUITips.showError("网络未连接", in: self.view, hideAfterDelay: 2.0)
        endRefreshing()
        NetService = nil
        if self.dataRecords.count<=0 {
            self.showInterNetFailEmptyView()
            //隐藏刷新控件
            hideRefresh()
        }
    }
    /// 连接服务器失败
    func serviceLinkFail() {
        endRefreshing()
        QMUITips.showError("连接服务器失败", in: self.view, hideAfterDelay: 2.0)
        NetService = nil
        if self.dataRecords.count<=0 {
            self.showLinkServiceFailEmptyView()
            hideRefresh()
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
        if cell == nil{
            cell = self.createTableViewCell()
        }
        cell?.setCellData(data: self.getCurrentRowData(index: indexPath as NSIndexPath))
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    /// 获取当前行的数据
    func getCurrentRowData(index:NSIndexPath) -> AnyObject? {
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

// MARK: - 网络请求回调 统一处理 不同的状态下 显示不同的提示页 当前子类可以根据具体的需求重写以下函数
extension JDXBaseTableViewController{
    /// 停止刷新 在此函数里面重置刷新控件的状态
    func endRefreshing() {
        if let header = self.tableView?.mj_header {
            header.endRefreshing()
        }
        if let footer = self.tableView?.mj_footer {
            footer.endRefreshing()
        }
    }
    
    /// 隐藏刷新控件
    func hideRefresh() {
        if let header = self.tableView?.mj_header{
            header.isHidden = true
        }
        if let footer = self.tableView?.mj_footer{
            footer.isHidden = true
        }
    }
    
    /// 显示刷新控件
    func showRefresh() {
        if let header = self.tableView?.mj_header{
            header.isHidden = false
        }
        if let footer = self.tableView?.mj_footer{
            footer.isHidden = false
        }
    }
    override func emptyDataAction() {
        loadDataWithEmptyLoadingView()
    }
    override func linkServiceFailAction() {
        loadDataWithEmptyLoadingView()
    }
    override func interNetFailAction() {
        loadDataWithEmptyLoadingView()
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
