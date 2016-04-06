//
//  BasicTableView.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/3/2.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class BasicTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        backgroundColor = kWhiteColor
        tableFooterView = UIView();
        separatorStyle = .SingleLineEtched;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
