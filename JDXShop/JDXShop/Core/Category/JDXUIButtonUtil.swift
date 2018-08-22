//
//  JDXUIButtonUtil.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/21.
//  Copyright © 2018年 3. All rights reserved.
//

import Foundation
import Kingfisher //图片加载库
extension UIButton{
    public func showImage(url:String?,state:UIControlState){
        if let actualUrl = url {
            let resource = ImageResource(downloadURL:NSURL.init(string: actualUrl)! as URL)
            self.kf.setImage(with: resource, for: state)
        }
    }
}
