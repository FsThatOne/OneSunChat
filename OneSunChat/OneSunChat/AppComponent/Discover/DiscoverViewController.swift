//
//  OSunDiscoverViewController.swift
//  OneSunChat
//
//  Created by 刘ToTo on 16/2/19.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class  DiscoverViewController: BasicViewController ,UITableViewDataSource, UITableViewDelegate {
    
    /// 朋友圈cell后边的图片容器
    var accessView = UIView(frame: CGRect(x: kScreenWidth - 75, y: 0, width: 45, height: 45))
    // MARK: - lazLoad
    
    // MARK: - layout
    override func loadView() {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "discoverCell")
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hasFriendNotify(cell: UITableViewCell){
        let photoView = UIImageView(image: UIImage(named: "AlbumListViewBkg.jpg"))
        photoView.frame = CGRect(x: 7.5, y: 7.5, width: 30, height: 30)
        let indicateView = UIImageView(image: UIImage(named: "dis_NewNotify"))
        indicateView.frame = CGRect(x: 29, y: 0, width: 16, height: 16)
        accessView.addSubview(photoView)
        accessView.addSubview(indicateView)
        cell.contentView.addSubview(accessView)
    }
    
}

// MARK: - UITableViewDelegate
extension DiscoverViewController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //扫一扫
        if (indexPath.section, indexPath.row) == (1, 0) {
            let QRCodeScanVC = QRCodeViewController(title: "二维码/条形码", hiddenTabBar: true)
            navigationController?.pushViewController(QRCodeScanVC, animated: true)
        }
        //摇一摇
        if (indexPath.section, indexPath.row) == (1, 1) {
            let shakeVC = ShakeViewController(title: "摇一摇", hiddenTabBar: true)
            navigationController?.pushViewController(shakeVC, animated: true)
        }
    }

}

// MARK: - UITableViewDataSource
extension DiscoverViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    
    func tableView(_ tableView: UITableView, heightForHeader InSection: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooter InSection: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "discoverCell")!
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        let cellText : String?
        let cellImageName : String?
        switch indexPath.section {
        case 0:
            cellText = "朋友圈"
            cellImageName = "Friend"
            hasFriendNotify(cell: cell)
        case 1:
            if indexPath.row == 0 {
                cellText = "扫一扫"
                cellImageName = "QRCode"
            }else{
                cellText = "摇一摇"
                cellImageName = "Shake"
            }
        case 2:
            if indexPath.row == 0 {
                cellText = "附近的人"
                cellImageName = "LocationService"
            }else{
                cellText = "漂流瓶"
                cellImageName = "Bottle"
            }
        default:
            if indexPath.row == 0 {
                cellText = "购物"
                cellImageName = "Games"
            }else{
                cellText = "游戏"
                cellImageName = "Games"
            }
        }
        cell.imageView?.image = UIImage(named: "dis_Icon" + cellImageName!)
        cell.textLabel?.attributedText = NSAttributedString(string: cellText!, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 16)])
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
}
