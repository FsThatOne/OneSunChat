//
//  ShakeViewController.swift
//  OneSunChat
//
//  Created by qufenqi on 16/2/25.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit

enum shakeType{
    case startShake
    case stopShake
}

class ShakeViewController: BasicViewController, UITabBarDelegate {
    
    var isShaking = false
    //音效播放
    private var voiceMaker: AVAudioPlayer!
    
    // MARK: - 懒加载控件
    //tabbar
    lazy var tabbar: UITabBar = {
        let tabbar = UITabBar()
        tabbar.barStyle = UIBarStyle.Black
        tabbar.tintColor = kTitleColor
        tabbar.delegate = self
        return tabbar
    }()
    //tabbarItems
    lazy var item1 = UITabBarItem(title: "人", image: UIImage(named: "Shake_icon_people"), selectedImage: UIImage(named: "Shake_icon_people_HL"))
    lazy var item2 = UITabBarItem(title: "歌曲", image: UIImage(named: "Shake_icon_music"), selectedImage: UIImage(named: "Shake_icon_music_HL"))
    lazy var item3 = UITabBarItem(title: "电视", image: UIImage(named: "Shake_icon_tv"), selectedImage: UIImage(named: "Shake_icon_tv_HL"))
    //摇一摇图片
    lazy var shakeUpImage = UIImageView(image: UIImage(named: "Shake_Logo_Up"))
    lazy var shakeDownImage = UIImageView(image: UIImage(named: "Shake_Logo_Down"))
    //摇一摇的中线
    lazy var upLine: UIImageView = {
        let imageVIew = UIImageView(image: UIImage(named: "Shake_Line_Up"))
        imageVIew.hidden = true
        return imageVIew
    }()
    lazy var downLIne: UIImageView = {
        let imageVIew = UIImageView(image: UIImage(named: "Shake_Line_Down"))
        imageVIew.hidden = true
        return imageVIew
    }()
    
    // MARK: - 生命周期方法
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 传感器方法
extension ShakeViewController{

    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        //guard守护,保证动画进行时不再重新定义动画
        guard isShaking != true else{
            return
        }
        isShaking = true
        self.updateLineStatus()
        let voiceURL = NSBundle.mainBundle().URLForResource("shake_sound", withExtension: "wav")
        do{
            try voiceMaker = AVAudioPlayer(contentsOfURL: voiceURL!)
        } catch{
            print("Error de reproducccion")
        }
        voiceMaker.play()
        // TODO: - 这里放摇一摇的逻辑

        UIView.animateWithDuration(0.35, animations: {
            self.updateConstraints(.startShake)
        }) { (isFinished) in
            UIView.animateWithDuration(0.35, delay: 0.4, options: UIViewAnimationOptions.LayoutSubviews, animations: {
                self.updateConstraints(.stopShake)
                }, completion: { (isFinished) in
                    self.isShaking = false
                    self.updateLineStatus()
            })
        }
    }
}

// MARK: - 界面
extension ShakeViewController{
    
    //初始界面
    func setupUI(){
        view.backgroundColor = kBackGroundColor
        tabbar.setItems([item1, item2, item3], animated: false)
        tabbar.selectedItem = tabbar.items![0]
        view.addSubview(tabbar)
        view.addSubview(shakeUpImage)
        view.addSubview(shakeDownImage)
        view.addSubview(upLine)
        view.addSubview(downLIne)
        addConstraints()
    }
    
    //中间的线是否显示
    func updateLineStatus(){
        upLine.hidden = !upLine.hidden
        downLIne.hidden = !downLIne.hidden
    }
    
    //添加约束
    func addConstraints() {
        tabbar.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(view.snp_bottom)
            make.height.equalTo(70)
        }
        shakeUpImage.snp_makeConstraints { (make) in
            make.bottom.equalTo(view.snp_centerY)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(225)
            make.height.equalTo(120)
        }
        shakeDownImage.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_centerY)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(225)
            make.height.equalTo(120)
        }
        upLine.snp_updateConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(shakeUpImage.snp_bottom)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(3)
        }
        downLIne.snp_updateConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(shakeDownImage.snp_top)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(3)
        }
    }
    
    //更新约束
    func updateConstraints(type: shakeType){
        switch type {
        case .startShake:
            shakeUpImage.snp_updateConstraints { (make) in
                make.bottom.equalTo(view.snp_centerY).offset(-75.0)
            }
            shakeDownImage.snp_updateConstraints { (make) in
                make.top.equalTo(view.snp_centerY).offset(75)
            }
        default:
            shakeUpImage.snp_updateConstraints { (make) in
                make.bottom.equalTo(view.snp_centerY)
            }
            shakeDownImage.snp_updateConstraints { (make) in
                make.top.equalTo(view.snp_centerY)
            }
        }
        view.layoutIfNeeded()
    }
}