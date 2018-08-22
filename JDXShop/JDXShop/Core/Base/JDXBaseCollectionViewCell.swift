//
//  JDXBaseCollectionViewCell.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXBaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        jdx_addSubViews()
    }
    
    // 子类需要重写的方法
    public func jdx_addSubViews(){
        
    }
    public func setCellData(data:AnyObject?){
        if let actualData = data {
            print(actualData)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
