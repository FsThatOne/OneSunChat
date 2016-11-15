//
//  OSunBasicNavigationController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class BasicNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK : - 设置状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
