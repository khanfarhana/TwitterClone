//
//  FollowingVC.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import UIKit
import Kingfisher
class FollowingVC: UIViewController {
    let authorization = "Bearer \("AAAAAAAAAAAAAAAAAAAAAHXqRQEAAAAA4ucG5vSGhWwoXLN6cw2ScGWfBnU%3Dwxi335NokqqvoOugjEiiLETMsii3i3ly0QYkwo17YAzsyw8XPd")"
    var screenName = [String]()
    var images = String()
    var id = [Int]()
    var img = [String]()
    var dict = [NSDictionary]()
    var dictData = NSDictionary()
    var imgUrl = String()
    var appendData = [String]()
    var demo = [String]()
    @IBOutlet weak var TV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        TV.rowHeight = UITableView.automaticDimension
        TV.estimatedRowHeight = 600
        TV.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func apiCall()  {
        let session = URLSession.shared
        let urll = URL(string: "https://api.twitter.com/2/users/1413392780420812800")!
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/users/1413392780420812800/following")!)
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
                            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                            let data = jsonData.value(forKey: "data") as? [NSDictionary]
                            self.dict = data!
                            let delayTime = DispatchTime.now() + 3.0
                            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
                                self.apiCall2()
                            })
                            DispatchQueue.main.async {
                                self.TV.reloadData()
                            }
                        }
                    }
                }
                catch {
                    print("exception")
                }
            }
            else {
                print(error!.localizedDescription)
            }
        }
        .resume()
    }
    
    func apiCall2()  {
        let session = URLSession.shared
        let urll = URL(string: "https://api.twitter.com/2/users/1413392780420812800")!
        for i in 0...self.dict.count-1 {
            let indexPath = IndexPath(row: i, section: 0)
            var request = URLRequest(url: (URL(string: "https://api.twitter.com/1.1/users/show.json?screen_name=\(screenName[indexPath.row])") ?? URL(string:"https://twitter.com/home"))!)
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
                                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                                self.dictData = jsonData
                            }
                        }
                        let profile = self.dictData.value(forKey: "profile_image_url") as! String
                        self.demo.append(profile)
                    }
                    catch {
                        print("exception")
                    }
                }
                else {
                    print(error!.localizedDescription)
                }
            }
            .resume()
        }
        TV.reloadData()
    }
}
extension FollowingVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FollowingCell
        let data = self.dict[indexPath.row]
        let uname = data.value(forKey: "username") as? String ?? ""
        let id = data.value(forKey: "id") as? Int ?? 0
        cell.nameLb.text = data.value(forKey: "name") as? String ?? ""
        self.screenName.append(uname)
        self.id.append(id)
        cell.userNameLb.text = uname
        _ = self.dictData.value(forKey: "profile_image_url") as? String ?? ""
        let delayTime = DispatchTime.now() + 5.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            let url = URL(string: self.demo[indexPath.row])
            cell.imgV!.kf.setImage(with: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "AnotherUserVC") as! AnotherUserVC
        let dict = dict[indexPath.row]
        vc.uname = dict.value(forKey: "username") as? String ?? ""
        vc.name = dict.value(forKey: "name") as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
}
