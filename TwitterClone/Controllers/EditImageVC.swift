//
//  EditImageVC.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import UIKit
import Kingfisher
class EditImageVC: UIViewController {
    @IBOutlet weak var imageV: UIImageView!
    var img = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: img)
        self.imageV.kf.setImage(with: url)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func editPress(_ sender: UIButton) {
    }
    
}
