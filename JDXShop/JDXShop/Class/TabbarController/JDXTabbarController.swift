//
//  JDXTabbarController.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit



class JDXTabbarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self;
        //去掉顶部横线
//        let TabBarLine = UITabBar.appearance()
//        TabBarLine.backgroundImage = UIImage.qmui_image(with: UIColor.white, size: CGSize.init(width: kScreen_Width, height: 50), cornerRadius: 0)
//        TabBarLine.shadowImage = UIImage()
//        TabBarLine.backgroundImage = UIImage()
        createSubViewControllers()
    }
    
    private func createSubViewControllers(){
        let layout = UICollectionViewFlowLayout()
        let homePage = JDXNavigationController.init(rootViewController: JDXHomeViewController.init(collectionViewLayout: layout))
        homePage.tabBarItem.title = "首页"
        homePage.tabBarItem.image = UIImage.init(named: "home_normal")
        homePage.tabBarItem.selectedImage = UIImage.init(named: "home_hightlight")
        
        let categoryPage = JDXNavigationController.init(rootViewController: JDXCategoryViewController())
        categoryPage.tabBarItem.title = "分类"
        categoryPage.tabBarItem.image = UIImage.init(named: "category_normal")
        categoryPage.tabBarItem.selectedImage = UIImage.init(named: "category_hightlight")
        
        let messagePage = JDXNavigationController.init(rootViewController: JDXMessageViewController())
        messagePage.tabBarItem.title = "消息"
        messagePage.tabBarItem.image = UIImage.init(named: "message_normal")
        messagePage.tabBarItem.selectedImage = UIImage.init(named: "message_hightlight")
        
        let shopPage = JDXNavigationController.init(rootViewController: JDXShopViewController())
        shopPage.tabBarItem.title = "购物车"
        shopPage.tabBarItem.image = UIImage.init(named: "shop_normal")
        shopPage.tabBarItem.selectedImage = UIImage.init(named: "shop_hightlight")
        
        let mePage = JDXNavigationController.init(rootViewController: JDXProfileViewController())
        mePage.tabBarItem.title = "我"
        mePage.tabBarItem.image = UIImage.init(named: "me_normal")
        mePage.tabBarItem.selectedImage = UIImage.init(named: "me_hightlight")
        
        tabBar.tintColor = UIColor.qmui_color(withHexString: "#919191")
        let pages = [homePage,categoryPage,messagePage,shopPage,mePage]
        self.viewControllers = pages
    }
}


extension JDXTabbarController{
     func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return JDXTabbarTransitioning.init(duration: 0.5);
     }
}
