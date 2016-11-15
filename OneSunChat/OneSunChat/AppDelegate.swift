//
//  AppDelegate.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow()
        window?.rootViewController = BasicTabBarController()
        window?.makeKeyAndVisible()
        
        
        let dict = ["cellClass":"Amer"]
        
        let model = BasicTableViewItem(dict: dict as [String : AnyObject]!)
        
        print(model.description)
        
        doAppearanceSetting()
    }
}

// MARK: - 设置全局渲染
extension AppDelegate{
    fileprivate func doAppearanceSetting() {
        // 控制nav背景色
        UINavigationBar.appearance().barTintColor = kBarTintColor
        // 控制nav标题属性
        UINavigationBar.appearance().titleTextAttributes = NSDictionary(object: kWhiteColor, forKey: NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject]
        // 控制nav左返回键
        UINavigationBar.appearance().tintColor = kWhiteColor
    }
}

