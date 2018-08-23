//
//  ViewController.swift
//  GoodsDetailPage
//
//  Created by lanhao on 2018/8/23.
//  Copyright © 2018年 lanhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UIScrollViewDelegate {
    var bottomScrollView:UIScrollView? = nil
    var topGoodsInfoView:UITableView? = nil
    var bottomView:UIScrollView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomScrollView = UIScrollView.init(frame: self.view.bounds)
        bottomScrollView?.backgroundColor = UIColor.red
        bottomScrollView?.isScrollEnabled = false
        bottomScrollView?.isPagingEnabled = true
        self.view.addSubview(self.bottomScrollView!)
        topGoodsInfoView = UITableView.init(frame: self.view.bounds)
        topGoodsInfoView?.delegate = self
        self.bottomScrollView?.addSubview(self.topGoodsInfoView!)
        
        
        bottomView = UIScrollView.init(frame: CGRect.init(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        bottomView?.backgroundColor = UIColor.cyan
        bottomView?.delegate = self
        self.bottomView?.contentSize = CGSize.init(width: 0, height: self.view.bounds.size.height*2)
        self.bottomScrollView?.addSubview(self.bottomView!)
        
        self.bottomScrollView?.contentSize = CGSize.init(width: 0, height: self.view.bounds.size.height*2)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        if scrollView == self.topGoodsInfoView {
            if y>=100.0{
                self.bottomScrollView?.setContentOffset(CGPoint.init(x: 0, y: self.view.bounds.size.height), animated: true)
            }
        }
        if scrollView == self.bottomView{
            if y <= -170{
                self.bottomScrollView?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
        }
    }
    
}

