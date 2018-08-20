//
//  ImageViewUtils.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/20.
//  Copyright © 2018年 3. All rights reserved.
//

import Foundation
import Kingfisher //图片加载库
extension UIImageView{
    public func showImage(url:String?,placeholder:String?){
        if let actualUrl = url{
            let resource = ImageResource(downloadURL:NSURL.init(string: actualUrl)! as URL)
            if  let actualPlaceHolder = placeholder{
                self.kf.setImage(with:resource, placeholder:UIImage.init(named:actualPlaceHolder), options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                self.kf.setImage(with: resource)
            }
        }
    }
}
