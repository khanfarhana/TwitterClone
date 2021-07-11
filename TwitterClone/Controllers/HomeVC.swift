//
//  SettingVC.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import UIKit
import SideMenu

class HomeVC: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "twitter")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func settingPress(_ sender: Any) {
        let menu = SideMenuNavigationController(rootViewController: SettingVC())
        menu.delegate = self
        menu.leftSide = true
        present(menu, animated: true, completion: nil)
    }
}
