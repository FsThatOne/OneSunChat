//
//  BasicTableViewDatasource.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/23.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

typealias creatCellClosure = () -> BasicTableViewCell

class BasicTableViewDatasource: NSObject, UITableViewDataSource{
    
    var items:[BasicDataModel]?
    var createCell:creatCellClosure?
    var isGroup:Bool{
        get{
            guard let itemsT = items?.first,
                itemsT.isKind(of: BasicTableViewGroupItem.self) else{
                return false
            }
            return true
        }
    }
    
    convenience init(customCell: @escaping creatCellClosure) {
        self.init()
        createCell = customCell
    }
}

// MARK: - dataSource Method
extension BasicTableViewDatasource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return isGroup ? (items?.count ?? 1) : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if isGroup {
            let group = items?[section] as! BasicTableViewGroupItem
            return group.subItems.count
        }
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var item: BasicTableViewItem
        if isGroup {
            let group = items?[indexPath.section] as! BasicTableViewGroupItem
            item = group.subItems[indexPath.row] 
        }else{
            item = items![indexPath.row] as! BasicTableViewItem
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: item.cellClass!) as? BasicTableViewCell
        if cell == nil ,
            let createCell = createCell{
                cell = createCell()
        }
        cell?.item = item
        return cell!
    }
}
