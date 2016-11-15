//
//  BasicWebViewController.swift
//  OneSunChat
//
//  Created by qufenqi on 16/2/25.
//  Copyright © 2016年 刘ToTo. All rights reserved.
//

import UIKit

class BasicWebViewController: BasicViewController {

    //懒加载webView控件
    lazy var webView: UIWebView = {
        let web = UIWebView(frame: self.view.frame)
        return web
    }()
    
    var requestUrl: URL?
    
    convenience init(title: String, url: String){
        self.init(title: title, imageName: nil)
        requestUrl = URL(string: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.loadRequest(NSURLRequest(url: requestUrl!) as URLRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
