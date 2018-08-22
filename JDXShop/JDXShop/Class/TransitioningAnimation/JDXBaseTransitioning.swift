//
//  JDXBaseTransitioning.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/22.
//  Copyright © 2018年 3. All rights reserved.
//

/*
 基础转场动画
 自定义转场动画 继承此类，并实现 func animateTransition(using transitionContext: UIViewControllerContextTransitioning,fromVC:UIViewController,toVC:UIViewController,fromView:UIView,toView:UIView) 即可
 */
import UIKit
class JDXBaseTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    /// 动画时长
    var duration:TimeInterval?
    init(duration:TimeInterval) {
        super.init()
        self.duration = duration
    }
    //MARK: - 实现协议方法
    internal  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration!
    }
    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC   = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromView = fromVC?.view
        let toView = toVC?.view
        self.animateTransition(using: transitionContext, fromVC: fromVC!, toVC: toVC!, fromView: fromView!, toView: toView!)
    }
    //TODO:子类需要实现的方法
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning,fromVC:UIViewController,toVC:UIViewController,fromView:UIView,toView:UIView){
        //在此方法里面实现自定义转场动画
    }
}
