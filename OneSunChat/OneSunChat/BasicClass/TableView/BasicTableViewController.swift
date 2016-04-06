//
//  BasicTableViewController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/23.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class BasicTableViewController: BasicViewController {
    
    
    override func loadView() {
        view = tableView
    }
    
    // MARK: - lazyloading
    lazy var tableView: BasicTableView = {
        let tableView:BasicTableView = BasicTableView(frame: CGRectZero, style: UITableViewStyle.Plain)
            
        return tableView
    }()
}
