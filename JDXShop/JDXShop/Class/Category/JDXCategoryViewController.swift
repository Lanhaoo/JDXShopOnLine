//
//  JDXCategoryViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXCategoryViewController: JDXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func jdx_addSubViews() {
        let titles = ["类目","品牌"]
        let view1 = UIView.init(frame: self.view.bounds)
        view1.backgroundColor = UIColor.cyan
        let view2 = UIView.init(frame: self.view.bounds)
        view2.backgroundColor = UIColor.blue
        let views = [view1,view2]
        let segmentView = LHSegmentMenuView.init(frame: self.view.bounds, titles: titles, views: views)
        self.view.addSubview(segmentView)
    }
}
