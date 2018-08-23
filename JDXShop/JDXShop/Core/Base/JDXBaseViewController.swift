//
//  JDXBaseViewController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXBaseViewController: UIViewController {
    var emptyView:QMUIEmptyView?
    var emptyViewShowing:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        jdx_addSubViews()
        
    }
    func jdx_addSubViews() {
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutEmptyView()
    }
    
    
}
// MARK: - 封装空白页提示
extension JDXBaseViewController{
    //显示loading的emptyView
    @objc func showEmptyViewWithLoading() {
        self.showEmptyView(showLoading: true,
                           image: nil,
                           text: nil,
                           detailText: nil,
                           buttonTitle: nil,
                           buttonAction:nil)
    }
    /// 显示只带一个文字提示的emptyView
    func showEmptyView(text:String) {
        self.showEmptyView(showLoading: false,
                           image: nil,
                           text: text,
                           detailText: nil,
                           buttonTitle: nil,
                           buttonAction:nil)
    }
    /// 显示一个带文字 和详细说明的 emptyView
    func showEmptyView(text:String,detailText:String){
        self.showEmptyView(showLoading: false,
                           image: nil,
                           text: text,
                           detailText: detailText,
                           buttonTitle: nil,
                           buttonAction:nil)
    }
    /// 显示一个 带图片 标题 详情 和 按钮的emptyView
    func showEmptyView(image:UIImage,
                       text:String,
                       detailText:String?,
                       buttonTitle:String,
                       buttonAction:Selector) {
        self.showEmptyView(showLoading: false,
                           image: image,
                           text: text,
                           detailText: detailText,
                           buttonTitle: buttonTitle,
                           buttonAction:buttonAction)
    }
    /// 显示网络未连接的 emptyView
    func showInterNetFailEmptyView() {
        self.showEmptyView(image: UIImage.init(named: "home_hightlight")!,
                           text: "网络未连接",
                           detailText: "请检查您当前的网络",
                           buttonTitle: "点击重试",
                           buttonAction:#selector(interNetFailAction))
    }
    /// 显示连接服务器失败的 emptyView
    func showLinkServiceFailEmptyView() {
        self.showEmptyView(showLoading: false,
                           image: UIImage.init(named: "home_hightlight")!,
                           text: "连接服务器失败",
                           detailText: nil,
                           buttonTitle: "点击重试",
                           buttonAction:#selector(linkServiceFailAction))
    }
    /// 列表空数据时的emptyView
    func showNODataEmptyView() {
        self.showEmptyView(showLoading: false,
                           image: UIImage.init(named: "home_hightlight")!,
                           text: "暂无数据",
                           detailText:nil,
                           buttonTitle: "点击重试",
                           buttonAction:#selector(emptyDataAction))
    }
    /// 按钮点击事件
    @objc func interNetFailAction() {
        print("interNetFailAction")
    }
    @objc func linkServiceFailAction() {
        print("linkServiceFailAction")
    }
    @objc func emptyDataAction() {
        print("emptyDataAction")
    }
    /// 移除emptyView的方法
    func hideEmptyView() {
        self.emptyView?.removeFromSuperview()
        self.emptyView = nil
    }
    /// 创建emptyView的方法 子类如果重写的话 先调用 hideEmptyView()
    @objc func showEmptyView() {
        hideEmptyView()
        if self.emptyView == nil {
            self.emptyView = QMUIEmptyView.init(frame: self.view.bounds)
        }
        self.view.addSubview(self.emptyView!)
    }
    /// 自定义emptyView的方法 该方法决定emptyView要显示的内容
    private func showEmptyView(showLoading:Bool,
                               image:UIImage?,
                               text:String?,
                               detailText:String?,
                               buttonTitle:String?,
                               buttonAction:Selector?){
        self.showEmptyView()
        self.emptyView?.setLoadingViewHidden(!showLoading)
        if let actualImage = image {
            self.emptyView?.setImage(actualImage)
        }
        if let actualText = text {
            self.emptyView?.setTextLabelText(actualText)
        }
        if let actualDetailText = detailText{
            self.emptyView?.setDetailTextLabelText(actualDetailText)
        }
        if let actualButtonTitle = buttonTitle{
            self.emptyView?.setActionButtonTitle(actualButtonTitle)
        }
        if let action = buttonAction {
            self.emptyView?.actionButton.removeTarget(nil, action: nil, for: UIControlEvents.allEvents)
            self.emptyView?.actionButton.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        }
    }
    func isEmptyViewShowing() -> Bool {
        return (self.emptyView != nil) && ((self.emptyView?.superview) != nil)
    }
    /// 更新emptyViewframe
    @objc func layoutEmptyView(){
        if let emptyView = self.emptyView{
            let viewDidLoad = emptyView.superview != nil && self.isViewLoaded
            if viewDidLoad{
                let newEmptySize = emptyView.superview!.bounds.size
                let oldEmptySize = emptyView.frame.size
                if !newEmptySize.equalTo(oldEmptySize){
                    emptyView.frame = CGRect.init(x: emptyView.frame.minX, y: emptyView.frame.minY, width: newEmptySize.width, height: newEmptySize.height)
                }
                
            }
        }
    }
    
}
