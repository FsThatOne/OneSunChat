//
//  ChatTableViewCell.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/3/2.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class ChatTableViewCell: BasicTableViewCell {
    override var item: BasicTableViewItem  {
        didSet{
            textLabel?.text = "ChatTableViewCell"
            var detail: String = ""
            switch(item.cellStyle){
            case .default :
                detail = "UITableViewCellStyleDefault"
            case .subtitle :
                detail = "UITableViewCellStyleSubtitle"
            case .value1 :
                detail = "UITableViewCellStyleValue1"
            case .value2 :
                detail = "UITableViewCellStyleValue2"
            }
            
            detailTextLabel?.text = detail
        }
    }

}
