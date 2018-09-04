//
//  LHSegmentMenuView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/1.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class LHSegmentMenuView: UIView,UIScrollViewDelegate {
    let horSpace:CGFloat = 10.0
    var topTitleViewHeight = scaleWidth(width: 50.0)
    var topView:UIView!
    var line:UIView!
    var lastSelectedTitleView:UIView?
    let bottomScrollView:UIScrollView = {
        var view = UIScrollView()
        view.bounces = false
        view.isPagingEnabled = true
        return view
    }()
    convenience init(frame: CGRect,titles:Array<String>,views:Array<UIView>) {
        self.init(frame:frame)
        backgroundColor = UIColor.white
        let menuTitleWidth = (frame.size.width - CGFloat((views.count+1))*horSpace)/CGFloat(views.count)
        topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: topTitleViewHeight))
        self.addSubview(topView)
        
        let titleContainerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: topView.frame.size.width, height: topTitleViewHeight-5.0))
        topView.addSubview(titleContainerView)
        for (index, value) in titles.enumerated() {
            let titleLabel = UILabel.init(frame: CGRect.init(x: horSpace + horSpace*CGFloat(index) + CGFloat(index) * menuTitleWidth, y: 0, width: menuTitleWidth, height: titleContainerView.frame.size.height))
            titleLabel.text = value
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleSelectedItem(_:)))
            titleLabel.addGestureRecognizer(tapGesture)
            titleContainerView.addSubview(titleLabel)
        }
        
        lastSelectedTitleView = titleContainerView.subviews[0]
        
        let width = textWidth(str: titles[0] as NSString, fontSize:15, height: titleContainerView.frame.size.height)
        line = UIView.init(frame: CGRect.init(x: 0, y: titleContainerView.frame.maxY, width: width, height: 5.0))
        line.center.x = lastSelectedTitleView!.center.x
        line.backgroundColor = UIColor.cyan
        topView.addSubview(line)

        
        

        self.bottomScrollView.frame = CGRect.init(x: 0, y: topView.frame.maxY, width: frame.size.width, height: frame.size.height - topTitleViewHeight)
        self.bottomScrollView.delegate = self
        self.bottomScrollView.contentSize = CGSize.init(width: self.bottomScrollView.bounds.size.width * CGFloat(views.count), height: self.bottomScrollView.bounds.size.height)
        self.addSubview(self.bottomScrollView)
        
        for (index, value) in views.enumerated() {
            let subContainerView = value
            subContainerView.frame = CGRect.init(x: self.bottomScrollView.bounds.size.width*CGFloat(index), y: 0, width: self.bottomScrollView.bounds.size.width, height: self.bottomScrollView.bounds.size.height)
            self.bottomScrollView.addSubview(subContainerView)
        }
        
        
        
    }
    @objc func handleSelectedItem(_ tapGes : UITapGestureRecognizer){
        if let actual = tapGes.view {
            lastSelectedTitleView = actual
            setLineCenterX()
        }
    }
    func setLineCenterX() {
        if let actual = lastSelectedTitleView{
            UIView.animate(withDuration: 0.2) {
                self.line.center.x = actual.center.x
            }
//            UIView.animate(withDuration: 0.5, animations: {
//                var rect = self.line.frame
//                rect.origin.y = actual.frame.maxY
//                rect.size.height = 5.0
//                self.line.frame = rect
//            }) { (finished) in
//                self.line.center.x = actual.center.x
//            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bottomScrollView.frame = CGRect.init(x: 0, y: topView.frame.maxY, width: frame.size.width, height: frame.size.height - topTitleViewHeight)
    }
    
    func textWidth(str:NSString,fontSize: CGFloat, height:CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = str.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
        return ceil(rect.width)
    }
}
extension LHSegmentMenuView{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        _ = scrollView.contentOffset.x
        
        
        
    }
}
