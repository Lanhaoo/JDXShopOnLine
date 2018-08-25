//
//  JDXGoodsInfoTableView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/24.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXGoodsInfoTableView: JDXBaseView,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView?
    var goodsNum:String?
    var goodsInfo:JDXProductDetailInfo?
    var headerView:UIView?
    var productNameLabel:UILabel?
    var descLabel :UILabel?
    var priceRangeLabel:UILabel?
    var oldPriceLabel:UILabel?
    var discountLabel:UILabel?
    var banner:JDXCustomScrollView?
    override func jdx_addSubViews() {
        tableView = UITableView.init(frame: self.frame)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView()
        self.addSubview(tableView!)
        tableView?.register(JDXGoodsInfoTableViewCell.self, forCellReuseIdentifier: "JDXGoodsInfoTableViewCell")

        createTableHeaderView()
    }
    //创建表格头视图 分为两个部分 上面是 banner 下面是商品的具体信息和价格
    func createTableHeaderView() {
        headerView = UIView()
        self.tableView?.tableHeaderView = headerView
        headerView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(self)
        })
        banner = JDXCustomScrollView()
        headerView?.addSubview(banner!)
        banner?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(self)
            make.height.equalTo(scaleWidth(width: 291.0))
        })
        productNameLabel = UILabel()
        productNameLabel?.font = UIFont.systemFont(ofSize: 17)
        productNameLabel?.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        productNameLabel?.text = ""
        productNameLabel?.numberOfLines = 0
        headerView?.addSubview(self.productNameLabel!)
        productNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.banner!.snp.bottom).offset(scaleWidth(width: 20.0))
            make.left.equalTo(scaleWidth(width: 17.0))
            make.right.equalTo(-scaleWidth(width: 17.0))
        })
        descLabel = UILabel()
        descLabel?.font = UIFont.systemFont(ofSize: 13)
        descLabel?.textColor = UIColor.qmui_color(withHexString: "#9b9b9b")
        descLabel?.numberOfLines = 0
        descLabel?.text = ""
        headerView?.addSubview(descLabel!)
        descLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.productNameLabel!.snp.bottom).offset(scaleWidth(width: 14.0))
            make.left.right.equalTo(self.productNameLabel!)
        })
        
        let bgView = UIView()
        headerView?.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.descLabel!.snp.bottom).offset(scaleWidth(width: 24.0))
            make.left.right.equalTo(self.productNameLabel!)
            make.height.equalTo(scaleWidth(width: 30.0))
            make.bottom.equalToSuperview().offset(-10)
        }
        priceRangeLabel = UILabel()
        priceRangeLabel?.textColor = UIColor.qmui_color(withHexString: "#ff9c00")
        priceRangeLabel?.font = UIFont.systemFont(ofSize: 25)
        priceRangeLabel?.text = ""
        bgView.addSubview(priceRangeLabel!)
        priceRangeLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        oldPriceLabel = UILabel()
        oldPriceLabel?.textColor = UIColor.qmui_color(withHexString: "#c2c2c2")
        oldPriceLabel?.font = UIFont.systemFont(ofSize: 13)
        oldPriceLabel?.text = ""
        bgView.addSubview(oldPriceLabel!)
        oldPriceLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.priceRangeLabel!.snp.right).offset(scaleWidth(width: 10.0))
            make.centerY.equalToSuperview()
        })
//        discountLabel = UILabel()
//        discountLabel?.backgroundColor = UIColor.qmui_color(withHexString: "#ffc600")
//        discountLabel?.textColor = UIColor.qmui_color(withHexString: "#ffffff")
//        discountLabel?.font = UIFont.systemFont(ofSize: 17)
//        discountLabel?.text = "8.6折"
//        bgView.addSubview(discountLabel!)
//        discountLabel?.snp.makeConstraints({ (make) in
//            make.left.equalTo(self.oldPriceLabel!.snp.right).offset(scaleWidth(width: 13.0))
//            make.centerY.equalToSuperview()
//            make.width.equalTo(scaleWidth(width: 46.0))
//            make.height.equalTo(scaleWidth(width: 21.0))
//        })
    }
    func updateUI(data:JDXProductDetailInfo) {
        self.goodsInfo = data
        if let picture = data.rContentPicture{
            var bannerUrls:Array<String>? = Array<String>()
            for item in picture {
                if let url = item.rPictureURL{
                    bannerUrls?.append(url)
                }
            }
            self.banner?.imageURLStringsGroup = bannerUrls
        }
        self.productNameLabel?.text = data.rPTitle
        self.descLabel?.text = data.rPTitleSec
        self.priceRangeLabel?.text = data.rPMinPrice! + data.rPMaxPrice!
        self.oldPriceLabel?.text = "¥"+data.rPOPrice!
        //设置完数据之后 更新 头视图 刷新列表 下面两个函数一起使用
        sizeHeaderToFit()
        self.tableView?.reloadData()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView?.frame = self.frame
    }
    //表格头视图 高度自适应
    func sizeHeaderToFit() {
        let headerView = self.tableView!.tableHeaderView!
        headerView.setNeedsLayout()
        headerView.layoutSubviews()
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        self.tableView?.beginUpdates()
        tableView?.tableHeaderView = headerView
        self.tableView?.endUpdates()
    }
}
extension JDXGoodsInfoTableView{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return scaleWidth(width: 10.0)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: scaleWidth(width: 10.0)))
        if self.goodsInfo != nil {
            view.backgroundColor = UIColor.qmui_color(withHexString: "#eeeeee")
        }else{
            view.backgroundColor = UIColor.white
        }
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : JDXGoodsInfoTableViewCell? = nil
        cell = tableView.dequeueReusableCell(withIdentifier: "JDXGoodsInfoTableViewCell") as? JDXGoodsInfoTableViewCell
        cell?.textLabel?.text = "测试"
//        if let actualCell = cell{
        
//            actualCell.backgroundView?.backgroundColor = UIColor.cyan
//        }
        return cell!
    }
}

class JDXGoodsInfoTableViewCell: JDXBaseTableViewCell {
    var leftTitleLabel:UILabel?
    var centerContentLabel:UILabel?
    var rightMoreLabel:UILabel?
    override func jdx_addSubViews() {
        leftTitleLabel = UILabel()
        leftTitleLabel?.font = UIFont.systemFont(ofSize: 13)
        leftTitleLabel?.textColor = UIColor.qmui_color(withHexString: "#9b9b9b")
        self.contentView.addSubview(leftTitleLabel!)
        leftTitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(scaleWidth(width: 17.0))
            make.centerY.equalToSuperview()
        })
        
        centerContentLabel = UILabel()
        centerContentLabel?.font = UIFont.systemFont(ofSize: 13)
        centerContentLabel?.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        self.contentView.addSubview(centerContentLabel!)
        centerContentLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftTitleLabel!.snp.right).offset(scaleWidth(width: 17.0))
        })
        
        rightMoreLabel = UILabel()
        rightMoreLabel?.text = ">"
        rightMoreLabel?.font = UIFont.systemFont(ofSize: 17)
        rightMoreLabel?.textColor = UIColor.qmui_color(withHexString: "#3b3b3b")
        self.contentView.addSubview(rightMoreLabel!)
        rightMoreLabel?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scaleWidth(width: 22.0))
        })
    }
}
