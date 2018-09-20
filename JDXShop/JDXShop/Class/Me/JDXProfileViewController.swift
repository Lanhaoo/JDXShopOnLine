//
//  JDXProfileViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

private let IMAGE_HEIGHT:CGFloat = scaleWidth(width: 152.0)
let kNavBarBottom = WRNavigationBar.navBarBottom()
private let NAVBAR_COLORCHANGE_POINT:CGFloat = CGFloat(kNavBarBottom)

class JDXProfileViewController: JDXBaseTableViewController {
    var headerView = JDXProfileHeaderView()
    var customerGetInfo = JDXCustomerASGetInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
//        QMUITips.showLoading("加载中", in: self.view!)
//        customerGetInfo.loadProfileInfo(complectedCallback: { (result) in
//            QMUITips.hideAllTips(in: self.view!)
//            self.customerGetInfo = result
//            DispatchQueue.main.async {
//                self.headerView.setData(data: result)
//                self.tableView?.reloadData()
//            }
//        }) {
//            QMUITips.hideAllTips(in: self.view!)
//        }
//
        QMUITips.showLoading("加载中", in: self.view!)
        let customerGet = NetworkService.JDXCustomerASGet()
        APIRouter<JDXCustomerASGetInfo>.request(api: customerGet) { (response) in
            QMUITips.hideAllTips(in: self.view!)
            switch response{
            case .succeed(let value):
                self.customerGetInfo = value
                DispatchQueue.main.async {
                    self.headerView.setData(data: value)
                    self.tableView?.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }

        // 设置导航栏颜色
        navBarBarTintColor = UIColor.qmui_color(withHexString: "#ffe53a")
        
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 0
        
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
        navBarShadowImageHidden =  true
        self.tableView?.contentInset = UIEdgeInsetsMake(-CGFloat(kNavBarBottom), 0, 0, 0);
    }
    override func jdx_addSubViews() {
        headerView.frame = CGRect.init(x: 0, y: 0, width: kScreen_Width, height: scaleWidth(width: 152.0))
        self.tableView?.tableHeaderView = headerView
        self.reuseIdentifier = "menuCell"
        self.tableView?.rowHeight = scaleWidth(width: 50.0)
        self.tableView?.register(JDXBaseTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        self.tableView?.register(JDXProfileOrderItemView.self, forHeaderFooterViewReuseIdentifier: "JDXProfileOrderItemView")
        self.tableView?.register(JDXProfileMoneyItemView.self, forHeaderFooterViewReuseIdentifier: "JDXProfileMoneyItemView")
    }
}
extension JDXProfileViewController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            navBarTintColor = UIColor.black.withAlphaComponent(alpha)
            navBarTitleColor = UIColor.black.withAlphaComponent(alpha)
            statusBarStyle = .default
            title = "我的"
        }
        else
        {
            navBarBackgroundAlpha = 0
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .default
            title = ""
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 0
        }
        if (section == 1){
            return 0
        }
        return self.customerGetInfo.rContentItem.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.001
        }
        return scaleWidth(width: 50.0)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return scaleWidth(width: 70.0)
        }
        if section == 1 {
            return scaleWidth(width: 54.0)
        }
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView()
        if section == 0{
            let leftLabel = UILabel()
            leftLabel.textColor = UIColor.qmui_color(withHexString: "#000000")
            leftLabel.font = UIFont.systemFont(ofSize: 15)
            leftLabel.text = "我的订单"
            bgView.addSubview(leftLabel)
            leftLabel.snp.makeConstraints { (make) in
                make.left.equalTo(scaleWidth(width: 15.0))
                make.centerY.equalToSuperview()
            }
            let rightLabel = UILabel()
            rightLabel.text = "查看全部"
            rightLabel.textColor = UIColor.qmui_color(withHexString: "#4a4a4a")
            rightLabel.font = UIFont.systemFont(ofSize: 12)
            bgView.addSubview(rightLabel)
            rightLabel.snp.makeConstraints { (make) in
                make.right.equalTo(-scaleWidth(width: 15.0))
                make.centerY.equalToSuperview()
            }
            return bgView
        }
        if section == 1{
            let leftLabel = UILabel()
            leftLabel.textColor = UIColor.qmui_color(withHexString: "#000000")
            leftLabel.font = UIFont.systemFont(ofSize: 15)
            leftLabel.text = "我的资产"
            bgView.addSubview(leftLabel)
            leftLabel.snp.makeConstraints { (make) in
                make.left.equalTo(scaleWidth(width: 15.0))
                make.centerY.equalToSuperview()
            }
            return bgView
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let orderItemView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JDXProfileOrderItemView") as! JDXProfileOrderItemView
            orderItemView.setData(data: self.customerGetInfo)
            return orderItemView
        }
        if section == 1 {
            let moneyItemView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JDXProfileMoneyItemView") as! JDXProfileMoneyItemView
            moneyItemView.setData(data: self.customerGetInfo)
            return moneyItemView
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:JDXBaseTableViewCell? = nil
        cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as? JDXBaseTableViewCell
        let cellData:rContentAsset = self.customerGetInfo.rContentItem[indexPath.row]
        cell?.textLabel?.text = cellData.rCItem
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textColor = UIColor.qmui_color(withHexString: "#000000")
        return cell!
    }
}
