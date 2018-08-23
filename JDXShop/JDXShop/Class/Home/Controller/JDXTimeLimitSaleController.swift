//
//  JDXTimeLimitSaleController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/23.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXTimeLimitSaleController: JDXBaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataWithEmptyLoadingView()
        self.reuseIdentifier = "JDXTimeLimitSaleCell"
        self.tableView?.rowHeight = scaleHeight(height: 126.0)
        self.tableView?.register(JDXTimeLimitSaleCell.self, forCellReuseIdentifier: self.reuseIdentifier)
    }
    override func initNetService() {
        self.NetService = JDXTableParseDataService<JDXTimeLimitInfo>()
        self.NetService?.configService(url:JDXApiDefine.productSearchKindGet,
                                       params: ["sSearchKind":1,"sShopNum":defaultShopNum],
                                       delegate: self)
    }
    override func requestSuccess(result: AnyObject?) {
        if let actualData = result as? JDXTimeLimitInfo {
            hideEmptyView()
            self.dataRecords = actualData.rContentAD!
            self.tableView?.reloadData()
        }
    }
    
}
