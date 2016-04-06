//
//  UIImage+Extension.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/26.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

extension UIImage{
    convenience init?(name: String, renderingMode: UIImageRenderingMode) {
        self.init(named: name)
        imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}