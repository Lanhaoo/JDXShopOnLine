//
//  JDXTabbarTransitioning.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/22.
//  Copyright © 2018年 3. All rights reserved.
//
/*
 底部工具栏 切换动画
 **/
import UIKit

class JDXTabbarTransitioning: JDXBaseTransitioning {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, fromView: UIView, toView: UIView) {
        
//        let containerView = transitionContext.containerView
//        toView.frame = transitionContext.finalFrame(for: toVC)
//        containerView.addSubview(toView)
//        containerView.sendSubview(toBack: toView)
//        UIView.animate(withDuration: self.duration!, animations: {
//            fromView.alpha = 0.0
//        }) { (finished) in
//            if (transitionContext.transitionWasCancelled){
//                fromView.alpha = 1.0
//            }else{
//                fromView.removeFromSuperview()
//                fromView.alpha = 1.0
//            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
        
    }
    
}
