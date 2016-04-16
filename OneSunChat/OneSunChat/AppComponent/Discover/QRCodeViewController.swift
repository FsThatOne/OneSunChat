//
//  QRCodeViewController.swift
//  OneSunChat
//
//  Created by qufenqi on 16/2/24.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit


enum scanType {
    case QRCode
    case BarCode
    case Animation
}

let grayWidth = (UIScreen.mainScreen().bounds.width - 250) * 0.5
let grayHeight = (UIScreen.mainScreen().bounds.height - 250) * 0.5

class QRCodeViewController: BasicViewController, UITabBarDelegate, AVCaptureMetadataOutputObjectsDelegate{
    
    /// 扫描到20次时,认为二维码已经稳定
    var maxDetectedCount: Int = 20
    /// 当前识别到二维码的次数
    var currentDetectedCount: Int = 0
    
    // MARK: - 懒加载控件
    //tabbar
    lazy var tabbar: UITabBar = {
        let tabbar = UITabBar()
        tabbar.barStyle = UIBarStyle.Black
        tabbar.delegate = self
        return tabbar
    }()
    //tabbarItems
    lazy var item1 = UITabBarItem(title: "二维码", image: UIImage(named: "ScanQRCode"), selectedImage: UIImage(named: "ScanQRCode_HL"))
    lazy var item2 = UITabBarItem(title: "条形码", image: UIImage(named: "ScanStreet"), selectedImage: UIImage(named: "ScanStreet_HL"))
    //scanView
    lazy var scanView: UIView = UIView()
    //scanView四角的图片
    lazy var upLeftImg = UIImageView(image: UIImage(named: "ScanQR1"))
    lazy var upRightImg = UIImageView(image: UIImage(named: "ScanQR2"))
    lazy var downLeftImg = UIImageView(image: UIImage(named: "ScanQR3"))
    lazy var downRightImg = UIImageView(image: UIImage(named: "ScanQR4"))
    //scanLine扫描线
    lazy var scanLine: UIImageView = {
        let scanLine = UIImageView(image: UIImage(named: "ScanLine"))
        scanLine.alpha = 0.5
        return scanLine
    }()
    //session
    lazy var session : AVCaptureSession = AVCaptureSession()
    //in&output
    lazy var inputDevice: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    lazy var outputData = AVCaptureMetadataOutput()
    //预览图层
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        return layer
    }()
    
    
    // MARK: - 生命周期函数 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        setUpSession()
        session.startRunning()
    }
    
    override func viewDidAppear(animated: Bool) {
        startAnimation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        session.stopRunning()
        view.layer.removeAllAnimations()
    }
    
    func startAnimation(){
        UIView.animateWithDuration(2.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLine.transform = CGAffineTransformMakeTranslation(0, self.scanView.bounds.height - 10)
        }
    }
}

// MARK: - 设置摄像头会话
extension QRCodeViewController{

    func setUpSession(){
        if !session.canAddInput(inputDevice) {
            print("can not add input device")
            return
        }
        if !session.canAddOutput(outputData) {
            print("can not add output data")
            return
        }
        session.addInput(inputDevice)
        session.addOutput(outputData)
        
        outputData.metadataObjectTypes = outputData.availableMetadataObjectTypes;
        outputData.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        for dataObject in metadataObjects {
            
            if let codeObject = dataObject as? AVMetadataMachineReadableCodeObject,
                obj = previewLayer.transformedMetadataObjectForMetadataObject(codeObject) as? AVMetadataMachineReadableCodeObject {
                if CGRectContainsRect(scanView.frame, obj.bounds) {
                    if currentDetectedCount > maxDetectedCount{
                        session.stopRunning()
                        // TODO: - 识别二维码之后的动作
//                        print(codeObject.stringValue)
                        let webViewController = BasicWebViewController(title: "", url: codeObject.stringValue)
                        navigationController?.pushViewController(webViewController, animated: true)
                    }else{
                        currentDetectedCount += 1
                    }
                }
            }
        }
    }
}

// MARK: - UITabBarDelegate
extension QRCodeViewController{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        scanLine.transform = CGAffineTransformIdentity
        item == tabBar.items![0] ? updateConstraints(.QRCode) : updateConstraints(.BarCode)
        view.layer.removeAllAnimations()
        startAnimation()
    }
}

// MARK: - 二维码界面的UI布局
extension QRCodeViewController{
    
    func setUpUI(){
        //设置Tabbar
        tabbar.setItems([item1, item2], animated: false)
        tabbar.selectedItem = tabbar.items![0]
        tabbar.tintColor = kTitleColor
        tabbar.alpha = 0.9
        view.addSubview(tabbar)
        //设置扫描框
        scanView.addSubview(upLeftImg)
        scanView.addSubview(upRightImg)
        scanView.addSubview(downLeftImg)
        scanView.addSubview(downRightImg)
        scanView.addSubview(scanLine)
        view.addSubview(scanView)
        addConstraints()
        setupLayers()
    }
    
    func setupLayers(){
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //镂空灰色蒙板
        let gray = CGColorCreateCopyWithAlpha(UIColor.blackColor().CGColor , 0.4)
        
        let left: CALayer = CALayer()
        let right: CALayer = CALayer()
        let top: CALayer = CALayer()
        let bottom: CALayer = CALayer()
        left.backgroundColor = gray
        right.backgroundColor = gray
        top.backgroundColor = gray
        bottom.backgroundColor = gray
        left.frame = CGRect(x: 0, y: 0, width: grayWidth, height: CGRectGetHeight(view.frame))
        right.frame = CGRect(x: kScreenWidth - grayWidth, y: 0, width: grayWidth, height: CGRectGetHeight(view.frame))
        top.frame = CGRect(x: grayWidth, y: 0, width: 250, height: grayHeight)
        bottom.frame = CGRect(x: grayWidth, y: kScreenHieght - grayHeight, width: 250, height: grayHeight)
        view.layer.addSublayer(left)
        view.layer.addSublayer(right)
        view.layer.addSublayer(top)
        view.layer.addSublayer(bottom)
    }
    
    func addConstraints(){
        tabbar.snp_makeConstraints { (make) in
            make.bottom.equalTo(view.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(59)
        }
        scanView.snp_makeConstraints { (make) in
            make.center.equalTo(view.snp_center)
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
        upLeftImg.snp_makeConstraints { (make) in
            make.left.equalTo(scanView.snp_left)
            make.top.equalTo(scanView.snp_top)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        upRightImg.snp_makeConstraints { (make) in
            make.right.equalTo(scanView.snp_right)
            make.top.equalTo(scanView.snp_top)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        downLeftImg.snp_makeConstraints { (make) in
            make.left.equalTo(scanView.snp_left)
            make.bottom.equalTo(scanView.snp_bottom)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        downRightImg.snp_makeConstraints { (make) in
            make.right.equalTo(scanView.snp_right)
            make.bottom.equalTo(scanView.snp_bottom)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        scanLine.snp_makeConstraints { (make) in
            make.height.equalTo(4)
            make.top.equalTo(scanView.snp_top).offset(3)
            make.width.equalTo(scanView.snp_width)
            make.left.equalTo(scanView.snp_left)
        }
    }
    //更新约束
    func updateConstraints(type: scanType) {
        switch type {
        case .QRCode:
            scanView.snp_updateConstraints { (make) in
                make.height.equalTo(250)
            }
//        case .BarCode:
        default:
            scanView.snp_updateConstraints { (make) in
                make.height.equalTo(150)
            }
        }
        scanView.layoutIfNeeded()
        scanLine.layoutIfNeeded()
    }
}