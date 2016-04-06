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
            case .Default :
                detail = "UITableViewCellStyleDefault"
            case .Subtitle :
                detail = "UITableViewCellStyleSubtitle"
            case .Value1 :
                detail = "UITableViewCellStyleValue1"
            case .Value2 :
                detail = "UITableViewCellStyleValue2"
            }
            
            detailTextLabel?.text = detail
        }
    }

}
