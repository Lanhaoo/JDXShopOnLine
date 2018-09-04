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
    var recommendFooterView:JDXRecommendFooterView?
    var banner:JDXCustomScrollView?
    let productModel = JDXHomePageProductInfo() //获取列表数据的模型层对象
    var recommendProducts:Array<JDXHomePageProductInfo>? = Array<JDXHomePageProductInfo>() //推荐商品数据源
    override func jdx_addSubViews() {
        tableView = UITableView.init(frame: self.frame)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView()
        self.addSubview(tableView!)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        tableView?.register(JDXRecommendFooterView.self, forHeaderFooterViewReuseIdentifier: "JDXRecommendFooterView")
        createTableHeaderView()
        
        loadCommendProduct()
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
    //获取推荐商品列表
    func loadCommendProduct() {
        productModel.loadProductData(page: 1, pageSize: 10, complectedCallback: { (result) in
            self.recommendProducts = result
            self.tableView?.reloadData()
        }) {
            
        }
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
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return scaleWidth(width: 201.0)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        recommendFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JDXRecommendFooterView") as? JDXRecommendFooterView
        if let data = self.recommendProducts {
            recommendFooterView?.setData(products: data)
            recommendProducts = nil
        }
        return recommendFooterView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scaleWidth(width: 40.0)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: scaleWidth(width: 40.0)))
        if self.goodsInfo != nil {
            view.backgroundColor = UIColor.qmui_color(withHexString: "#f5f5f5")
        }else{
            view.backgroundColor = UIColor.white
        }
        let label = UILabel()
        label.text = "推荐商品"
        label.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(scaleWidth(width: 17.0))
            make.centerY.equalToSuperview()
        }
        return view
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = nil
        cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        return cell!
    }
}
class JDXRecommendFooterView: UITableViewHeaderFooterView {
    var gridView:QMUIGridView?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        gridView = QMUIGridView.init(frame: CGRect.init(x: 0, y: 0, width: kScreen_Width, height: scaleWidth(width: 200.0)))
        gridView?.columnCount = 4
        gridView?.rowHeight = scaleWidth(width: 200.0)/2
        gridView?.separatorWidth = 0.5
        self.addSubview(gridView!)
    }
    func setData(products:Array<JDXHomePageProductInfo>) {
        for item in products {
            let itemView = JDXRecommendProductGridViewItemView()
            itemView.setItem(data: item)
            gridView?.addSubview(itemView)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class JDXRecommendProductGridViewItemView: JDXBaseView {
    let imageView:UIImageView = {
        var iv = UIImageView()
        return iv
    }()
    let titleLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        return label
    }()
    override func jdx_addSubViews() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.imageView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
    }
    func setItem(data:JDXHomePageProductInfo)  {
        self.imageView.showImage(url: data.rPictureURL, placeholder: nil)
        self.titleLabel.text = data.rADTitle
    }
    
}

