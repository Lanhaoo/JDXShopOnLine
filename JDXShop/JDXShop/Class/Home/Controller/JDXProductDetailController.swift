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
        loadData()
        self.reuseIdentifier = "JDXBaseTableViewCell"
    }
    override func initNetService() {
        self.NetService = JDXTableParseDataService<JDXBaseModel>()
        self.NetService?.createService(url: JDXApiDefine.recommendPageGet, params: ["sPosition":2,"iPageNo":1,"iPagePer":10], delegate: self)
    }
}
