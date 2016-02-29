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
    
    var requestUrl: NSURL?
    
    convenience init(title: String, url: String){
        self.init(title: title, imageName: nil)
        requestUrl = NSURL(string: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        webView.loadRequest(NSURLRequest(URL: requestUrl!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
