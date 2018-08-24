//
//  ViewController.swift
//  GoodsDetailPage
//
//  Created by lanhao on 2018/8/23.
//  Copyright © 2018年 lanhao. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    var bottomScrollView:UIScrollView? = nil
    var topGoodsInfoView:UITableView? = nil
    var bottomView:UIView? = nil
    var bottomWebView:WKWebView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomScrollView = UIScrollView.init(frame: self.view.bounds)
        bottomScrollView?.backgroundColor = UIColor.red
        bottomScrollView?.isScrollEnabled = false
        bottomScrollView?.isPagingEnabled = true
        bottomScrollView?.showsVerticalScrollIndicator = false
        self.view.addSubview(self.bottomScrollView!)
        topGoodsInfoView = UITableView.init(frame: self.view.bounds)
        topGoodsInfoView?.delegate = self
        topGoodsInfoView?.dataSource = self;
        topGoodsInfoView?.tableFooterView = UIView()
        self.topGoodsInfoView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.bottomScrollView?.addSubview(self.topGoodsInfoView!)
    
        weak var weakself = self
        self.topGoodsInfoView?.addFooterRefresh {
            weakself?.bottomScrollView?.setContentOffset(CGPoint.init(x: 0, y: self.view.bounds.size.height), animated: true)
            weakself?.topGoodsInfoView?.mj_footer.endRefreshing()
        }
        
        
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        bottomView?.backgroundColor = UIColor.cyan
        self.bottomScrollView?.addSubview(self.bottomView!)
        self.createBottomSubViews()
        
        self.bottomScrollView?.contentSize = CGSize.init(width: 0, height: self.view.bounds.size.height*2)
    }
    
    func createBottomSubViews() {
        let webConfiguration = WKWebViewConfiguration()
        self.bottomWebView = WKWebView.init(frame:CGRect.init(x: 0, y: 0, width: self.bottomView!.bounds.size.width, height: self.bottomView!.bounds.size.height), configuration: webConfiguration)
        self.bottomWebView?.load(URLRequest.init(url: URL.init(string: "https://www.jianshu.com/p/091bf2467d67")!))
        self.bottomView?.addSubview(self.bottomWebView!)
        self.bottomWebView?.backgroundColor = UIColor.red
        weak var weakself = self
        self.bottomWebView?.scrollView.addHeaderRefresh {
            weakself?.bottomScrollView?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            weakself?.bottomWebView?.scrollView.mj_header.endRefreshing()
        }
    }
}

extension ViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.topGoodsInfoView {
            return 10
        }
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
}

