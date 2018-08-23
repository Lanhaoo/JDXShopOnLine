//
//  JDXProductDetailController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXProductDetailController: JDXBaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataWithEmptyLoadingView()
        self.reuseIdentifier = "JDXBaseTableViewCell"
        weak var weakSelf = self
        self.tableView?.addHeaderRefresh {
            weakSelf?.loadData()
        }
        self.tableView?.addFooterRefresh {
            weakSelf?.loadMoreData()
        }
    }
    override func initNetService() {
        self.NetService = JDXTableParseDataService<JDXBaseModel>()
        self.NetService?.configService(url:JDXApiDefine.recommendPageGet,
                                    params: ["sPosition":6,"iPageNo":1,"iPagePer":10],
                                  delegate: self)
    }
}
