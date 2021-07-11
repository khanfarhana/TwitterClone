//
//  ViewController.swift
//  TwitterClone
//
//  Created by Farhana Khan on 09/07/21.
//
import UIKit
class LoginVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var unameTf: UITextField!
    @IBOutlet weak var passTf: UITextField!
    let authorization = "Bearer \("AAAAAAAAAAAAAAAAAAAAAHXqRQEAAAAA4ucG5vSGhWwoXLN6cw2ScGWfBnU%3Dwxi335NokqqvoOugjEiiLETMsii3i3ly0QYkwo17YAzsyw8XPd")"
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "twitter")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        unameTf.setUnderLine()
        passTf.setUnderLine()
        execute()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func execute() {
        let session = URLSession.shared
        let urll = URL(string: "https://api.twitter.com/2/users/1413392780420812800")!
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/users/1413392780420812800")!)
        if authorization != "" {
            request.addValue(authorization, forHTTPHeaderField: "Authorization")
        }
        
        session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if error == nil {
                do {
                    _ = response as! HTTPURLResponse
                    _ = try NSString(contentsOf: urll,encoding: String.Encoding.utf8.rawValue)
                    let accessToken = "AAAAAAAAAAAAAAAAAAAAAHXqRQEAAAAA4ucG5vSGhWwoXLN6cw2ScGWfBnU%3Dwxi335NokqqvoOugjEiiLETMsii3i3ly0QYkwo17YAzsyw8XPd"
                    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                    if let data = data {
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            print(jsonData)
                        }
                    }
                } catch {
                    
                }
            } else {
                print(error!.localizedDescription)
            }
        }
        .resume()
    }
    
    @IBAction func loginVC(_ sender: UIButton) {
        //        email khanfarhana2014@gmail.com pass farhana@7
        if unameTf.text == "khanfarhana2014@gmail.com" && passTf.text == "farhana@7" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let alert = UIAlertController(title: "OOPS!", message: "Incorrect username or password", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUp(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension LoginVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
}

extension UITextField {
    
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.systemBlue.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
}
