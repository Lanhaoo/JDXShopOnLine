//
//  LHCacheManager.swift
//  JDXShop
//
//  Created by Fashion-205 on 2018/9/8.
//  Copyright © 2018年 3. All rights reserved.
//

import UIKit
class LHCacheManager: NSObject {
    static let cacheManager = LHCacheManager()
    
    func setObject(value:AnyObject,key:String)  {
        let cache = YYCache.init(name: "JDXShop")
        cache?.setObject(value as? NSCoding, forKey: key)
    }
    func object(key:String) -> AnyObject? {
        let cache = YYCache.init(name: "JDXShop")
        return cache?.object(forKey: key)
    }
    
    func loadCacheDir(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(paths[0])
    }

}
