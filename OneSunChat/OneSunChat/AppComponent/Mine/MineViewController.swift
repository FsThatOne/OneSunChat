//
//  OSunMineViewController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class MineViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - layout
    
    override func loadView() {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mineCell")
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - UITableViewDelegate
extension MineViewController{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 45
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mineCell")!
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        let cellText : String?
        let cellImageName : String?
        switch indexPath.section {
        case 0:
            let firstCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mineFirstCell")
            firstCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            firstCell.textLabel?.attributedText = NSAttributedString(string: "朋友圈", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)])
            firstCell.detailTextLabel?.text = "你是谁"
            let photoView = UIImageView(image: UIImage(named: "dis_IconFriend"))
            photoView.frame = CGRect(x: kScreenWidth - 70, y: 25, width: 30, height: 30)
            firstCell.contentView.addSubview(photoView)
            firstCell.imageView?.image = UIImage(named: "dis_IconFriend")
            return firstCell
        case 1:
            switch indexPath.row {
            case 0:
                cellText = "相册"
                cellImageName = "Friend"
            case 1:
                cellText = "收藏"
                cellImageName = "Friend"
            case 2:
                cellText = "钱包"
                cellImageName = "Friend"
            default:
                cellText = "优惠券"
                cellImageName = "Friend"
            }
        case 2:
            cellText = "表情"
            cellImageName = "Bottle"
        default:
            cellText = "设置"
            cellImageName = "Bottle"
        }
        cell.imageView?.image = UIImage(named: "dis_Icon" + cellImageName!)
        cell.textLabel?.attributedText = NSAttributedString(string: cellText!, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)])
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
}
