//
//  SignupVC.swift
//  TwitterClone
//
//  Created by Farhana Khan on 11/07/21.
//

import UIKit
import WebKit
class SignupVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet var webKit: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webKit.navigationDelegate = self
        webKit.uiDelegate = self
        webKit.backgroundColor = .clear
        signUP()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func signUP()  {
        let urlReq = URLRequest(url: URL(string: "https://twitter.com/i/flow/signup")!)
        webKit.load(urlReq)
    }
}
