//
//  SettingVC.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import UIKit


protocol MenuControllerDelegate{
    func didSelectMenuItem(name: String)
}


class SettingVC: UITableViewController {
    public var delegate: MenuControllerDelegate?
    
    let authorization = "Bearer \("AAAAAAAAAAAAAAAAAAAAAHXqRQEAAAAA4ucG5vSGhWwoXLN6cw2ScGWfBnU%3Dwxi335NokqqvoOugjEiiLETMsii3i3ly0QYkwo17YAzsyw8XPd")"
    let twitterArr = ["Profile", "Lists","Topics","Bookmarks","Momemts","Monetisation"]
    var data = NSDictionary()
    var uname = String()
    var name = String()
    var following = Int()
    var follower = Int()
    var profile = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        apiCall()
    }
    
    func apiCall()  {
        let session = URLSession.shared
        let urll = URL(string: "https://api.twitter.com/2/users/1413392780420812800")!
        var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/users/show.json?screen_name=Farhana48856265")!)
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
                            self.data = jsonData
                            let userName = jsonData.value(forKey: "screen_name") as? String ?? ""
                            let name = jsonData.value(forKey: "name") as? String ?? ""
                            let profileImage = jsonData.value(forKey: "profile_image_url") as? String ?? ""
                            let followers = jsonData.value(forKey: "followers_count") as? Int ?? 0
                            let following = jsonData.value(forKey: "friends_count") as? Int ?? 0
                            self.uname = userName
                            self.name = name
                            self.profile = profileImage
                            self.following = following
                            self.follower = followers
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            print(jsonData)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitterArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = twitterArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 200))
        let image = UIImageView(frame: CGRect(x: 16, y: 20, width: 50, height: 50))
        //        image.layer.cornerRadius = image.frame.size.width/2
        let url = URL(string: profile)
        image.kf.setImage(with: url)
        let name = UILabel(frame: CGRect(x: 16, y: 80, width: tableView.frame.size.width, height: 20))
        name.text = "\(self.name)"
        let uname = UILabel(frame: CGRect(x: 16, y: 110, width: tableView.frame.size.width, height: 20))
        uname.text = "@\(self.uname)"
        let following = UILabel(frame: CGRect(x: 16, y: 140, width: 100, height: 20))
        following.text = "\(self.following) Following"
        let followers = UILabel(frame: CGRect(x: 120, y: 140, width: 100, height: 20))
        followers.text = "\(follower) Followers"
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(uname)
        view.addSubview(following)
        view.addSubview(followers)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = twitterArr[indexPath.row]
        delegate?.didSelectMenuItem(name: selectedItem)
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "ProfileViewController")
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
