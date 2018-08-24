
//
//  JDXNavigationController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXNavigationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self;
        self.interactivePopGestureRecognizer?.delegate = self;
        
        self.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
        //去掉底部横线
//        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationBar.shadowImage = UIImage()
    }

}
extension JDXNavigationController{
    //MARK:-- 统一实现 push到二级页面时，隐藏底部工具栏
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.childViewControllers.count>0){
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    //MARK:-- 解决 如果在当前导航栈 栈定的时候 执行右滑返回是 界面卡死的bug
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if (self.childViewControllers.first == viewController) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }else{
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}
