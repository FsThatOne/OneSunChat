//
//  BasicDataModel.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/23.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

/**
 *  数据配置协议
 */
@objc public protocol DataModelConfigProtocol : NSObjectProtocol{
    @objc optional func configDict() -> [String:String]?
}

class BasicDataModel: NSObject, DataModelConfigProtocol{
    convenience init(dict:[String : Any]!) {
        self.init()
        var outCount:UInt32 = 0
        let property_list = class_copyPropertyList(self.classForCoder, &outCount)
        var config: [String:String]? = nil
        
        if self.responds(to: #selector(configDict)) {
            config = self.configDict()
        }
        //遍历属性
        for i in 0 ..< Int(outCount) {
            let property = property_list?[i]
            let pName = NSString(cString: property_getName(property),
                encoding: String.Encoding.utf8.rawValue)!
            if let pValue = dict[pName as String] {
                self.setValue(pValue, forKey: pName as String)
            }else if let cName = config?[pName as String]{
                if let pValue = dict[cName]{
                    self.setValue(pValue, forKey: pName as String)
                }
            }
        }
    }
    
    /// 模型数据配置方法
    /// 子类重写这个协议方法，可解决网络数据和模型属性名称不匹配
    /// - returns: [模型属性：网络数据字段名称］
    func configDict() -> [String:String]? {
        return nil
    }
    
    /// 对象描述模版，子类重写
    //    override var description: String {
    //        return "name is \(name) ,\n age is \(age),a \(a), tt\(tt) hasBMW \(hasBMW)"
    //    }
    
}
