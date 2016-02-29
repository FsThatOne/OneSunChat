//
//  OSunBasicViewController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit


class BasicViewController: UIViewController {
    // MARK: - 构造函数
    convenience init(title: String, imageName: String?) {
        self.init()
        self.title = title
        //如果imageName为空则直接返回
        guard (imageName != nil) else{
            return
        }
        var img = UIImage(named: imageName!)
        img = img?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        var imgS = UIImage(named: imageName! + "HL")
        imgS = imgS?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabBarItem.image = img!
        tabBarItem.selectedImage = imgS!
    }
    convenience init(title: String, hiddenTabBar: Bool) {
        self.init(title: title, imageName: nil)
        hidesBottomBarWhenPushed = hiddenTabBar
    }
    
    // MARK: - layout
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kLightBackGroundColor
    }
    
    // MARK: - custom method
    
    
    // MARK: - lazyloading
    lazy var backBarButton: UIBarButtonItem = {
        let backImage:UIImage = UIImage(named: "back_nav_icon")!
        var backBarButton = UIBarButtonItem(image: backImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("viewDidLoad"))
        return backBarButton
    }()
}

