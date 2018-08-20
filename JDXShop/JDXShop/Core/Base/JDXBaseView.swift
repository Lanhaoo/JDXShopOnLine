//
//  JDXBaseView.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/8/14.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit

class JDXBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        jdx_addSubViews()
    }
    
    public func jdx_addSubViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
