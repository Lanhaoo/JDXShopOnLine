//
//  HomePageBannerView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
class HomePageBannerView: UICollectionReusableView {
    var banner:JDXCustomScrollView!
    let bannerModel=HomePageBanner()
    override init(frame: CGRect) {
        super.init(frame: frame)
        jdx_addSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func jdx_addSubViews() {
        banner = JDXCustomScrollView.init(frame: self.bounds)
        self.addSubview(banner)
    }
    //通过c层 传递回网络请求的结果
    func setData(result:Array<HomePageBanner>){
        var banners : Array<String> = Array<String>()
        for item in result{
            if let url = item.rPictureURL{
                banners.append(url)
            }
        }
        self.banner.imageURLStringsGroup = banners
    }
    override func layoutSubviews() {
        self.banner.frame = self.bounds
    }
}
