//
//  TabBarController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class BasicTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [chatController,
                           ContactController,
                           discoverController,
                           mineController]
        // tab背景色
        tabBar.barTintColor = kWhiteColor
        // tab字体颜色
        tabBar.tintColor = kTitleColor
    }
    
    
    // MARK: - lazyload
    lazy var chatController: BasicNavigationController = {
        let chatVc = ChatViewController(title: "微信", imageName: "tabbar_mainframe")
        let chatNc = BasicNavigationController(rootViewController: chatVc)
        return chatNc
    }()
    
    lazy var ContactController: BasicNavigationController = {
        let contVc = ContactViewController(title: "通讯录", imageName: "tabbar_contacts")
        let contNc = BasicNavigationController(rootViewController: contVc)
        return contNc
    }()
    
    lazy var discoverController: BasicNavigationController = {
        let discVc = DiscoverViewController(title: "发现", imageName: "tabbar_discover")
        let discNc = BasicNavigationController(rootViewController: discVc)
        return discNc
    }()
    
    lazy var mineController: BasicNavigationController = {
        let mineVc = MineViewController(title: "我的", imageName: "tabbar_me")
        let mineNc = BasicNavigationController(rootViewController: mineVc)
        return mineNc
    }()

    

}
