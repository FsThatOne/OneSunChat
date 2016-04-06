//
//  OSunChatViewController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class ChatViewController: BasicTableViewController {
    // MARK: - layout
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
        // TODO: - 测试代码
        dataSource.items =
            [
            BasicTableViewGroupItem(dict:
                ["subItems" :
                    [
                        BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0]),
                        BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0]),BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0])]
                    ]),
                BasicTableViewGroupItem(dict:
                    ["subItems" :
                        [
                            BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0]),
                            BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0]),BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0])]
                    ]),
                BasicTableViewGroupItem(dict:
                    ["subItems" :
                        [
                            BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0]),
                            BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0]),BasicTableViewItem(dict: ["cellClass":"ChatTableViewCell","cellStyle":0])]
                    ])
        ]
    }
    
    
    lazy var dataSource: BasicTableViewDatasource = {
        let dataSource = BasicTableViewDatasource()
        dataSource.createCell = {() -> BasicTableViewCell in
            return ChatTableViewCell(style: .Value1,
                           reuseIdentifier: "ChatTableViewCell")
        }
        return dataSource
    }()
}
