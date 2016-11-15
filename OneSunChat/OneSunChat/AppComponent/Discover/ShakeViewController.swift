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
        tabbar.barStyle = UIBarStyle.black
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
        imageVIew.isHidden = true
        return imageVIew
    }()
    lazy var downLIne: UIImageView = {
        let imageVIew = UIImageView(image: UIImage(named: "Shake_Line_Down"))
        imageVIew.isHidden = true
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

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        //guard守护,保证动画进行时不再重新定义动画
        guard isShaking != true else{
            return
        }
        isShaking = true
        self.updateLineStatus()
        let voiceURL = Bundle.main.url(forResource: "shake_sound", withExtension: "wav")
        do{
            let voiceMaker = try AVAudioPlayer(contentsOf: voiceURL!)
            voiceMaker.play()
        } catch{
            print("Error de reproducccion")
        }

        // TODO: - 这里放摇一摇的逻辑

        UIView.animate(withDuration: 0.35, animations: {
            self.updateConstraints(type: .startShake)
        }) { (isFinished) in
            UIView.animate(withDuration: 0.35, delay: 0.4, options: UIViewAnimationOptions.layoutSubviews, animations: {
                self.updateConstraints(type: .stopShake)
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
        upLine.isHidden = !upLine.isHidden
        downLIne.isHidden = !downLIne.isHidden
    }
    
    //添加约束
    func addConstraints() {
        tabbar.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(70)
        }
        shakeUpImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(225)
            make.height.equalTo(120)
        }
        shakeDownImage.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(225)
            make.height.equalTo(120)
        }
        upLine.snp.updateConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(shakeUpImage.snp.bottom)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(3)
        }
        downLIne.snp.updateConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(shakeDownImage.snp.top)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(3)
        }
    }
    
    //更新约束
    func updateConstraints(type: shakeType){
        switch type {
        case .startShake:
            shakeUpImage.snp.updateConstraints { (make) in
                make.bottom.equalTo(view.snp.centerY).offset(-75.0)
            }
            shakeDownImage.snp.updateConstraints { (make) in
                make.top.equalTo(view.snp.centerY).offset(75)
            }
        default:
            shakeUpImage.snp.updateConstraints { (make) in
                make.bottom.equalTo(view.snp.centerY)
            }
            shakeDownImage.snp.updateConstraints { (make) in
                make.top.equalTo(view.snp.centerY)
            }
        }
        view.layoutIfNeeded()
    }
}
