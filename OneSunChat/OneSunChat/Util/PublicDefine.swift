//
//  PublicDefine.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/24.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

// MARK: - App
let App_Name = NSBundle.mainBundle().infoDictionary?["CFBundleDisplayName"] ?? ""
let App_Version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] ?? ""

// MARK: - Screen
/// 屏幕宽度
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
/// 屏幕高度
let kScreenHieght = UIScreen.mainScreen().bounds.size.height
/// 屏幕大小
let kScreenBounds = UIScreen.mainScreen().bounds

// MARK: - Color
/// 三原色_alpha
func RGB_A (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

/// 三原色
func RGB (r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

/// tab绿
let kTitleColor = RGB(26,g: 178,b: 10)
/// bar背景色
let kBarTintColor = UIColor(white: 10.0/255.0, alpha: 1.0)
/// 黑色北京
let kBackGroundColor = UIColor(white: 30.0/255.0, alpha: 1.0)
/// 微灰色背景
let kLightBackGroundColor = UIColor(white: 0.9, alpha: 1.0)

let kWhiteColor = UIColor.whiteColor()
let kBlackColor = UIColor.blackColor()
let kGreenColor = UIColor.greenColor()
