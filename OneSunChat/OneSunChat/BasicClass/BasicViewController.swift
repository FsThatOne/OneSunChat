//
//  OSunBasicViewController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit


class BasicViewController: UIViewController {
        // MARK: - layout
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kLightBackGroundColor
    }
    
    // MARK: - lazyloading
    lazy var backBarButton: UIBarButtonItem = {
        let backImage:UIImage = UIImage(named: "back_nav_icon")!
        var backBarButton = UIBarButtonItem(image: backImage, style: .Plain, target: self, action: Selector("backBarClick"))
        return backBarButton
    }()
}

// MARK: - convenience
extension BasicViewController{
    convenience init(title: String, imageName: String?) {
        self.init()
        self.title = title
        //如果imageName为空则直接返回
        guard (imageName != nil) else{
            return
        }
        tabBarItem.image = UIImage(name: imageName!,
            renderingMode: .AlwaysOriginal)
        tabBarItem.selectedImage = UIImage(name: imageName! + "HL",
            renderingMode: .AlwaysOriginal)
    }
    
    convenience init(title: String, hiddenTabBar: Bool) {
        self.init(title: title, imageName: nil)
        hidesBottomBarWhenPushed = hiddenTabBar
    }

}

// MARK: - custom method
extension BasicViewController{
    func backBarClick(){
        if (self.navigationController != nil) {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}


