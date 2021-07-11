//
//  ProfileVC.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import UIKit
import Kingfisher
class ProfileVC: UIViewController {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var followingLb: UILabel!
    @IBOutlet weak var followerLb: UILabel!
    var url =  String()
    let authorization = "Bearer \("AAAAAAAAAAAAAAAAAAAAAHXqRQEAAAAA4ucG5vSGhWwoXLN6cw2ScGWfBnU%3Dwxi335NokqqvoOugjEiiLETMsii3i3ly0QYkwo17YAzsyw8XPd")"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        apiCall()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfile(_ sender: UIButton) {
        
    }
    
    @objc func changeProfile() {
        let vc = storyboard?.instantiateViewController(identifier: "EditImageVC") as! EditImageVC
        vc.img = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func bannerImage() {
        
    }
    
    func setUp() {
        editBtn.layer.borderColor = UIColor.systemBlue.cgColor
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeProfile)))
        coverImage.isUserInteractionEnabled = true
        coverImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bannerImage)))
        followingLb.isUserInteractionEnabled = true
        followingLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(followingPress)))
        followerLb.isUserInteractionEnabled = true
        followerLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(followerPress)))
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
                            let userName = jsonData.value(forKey: "screen_name") as? String ?? ""
                            let name = jsonData.value(forKey: "name") as? String ?? ""
                            let profileImage = jsonData.value(forKey: "profile_image_url") as? String ?? ""
                            let bannerImage = jsonData.value(forKey: "profile_banner_url") as? String ?? ""
                            let followers = jsonData.value(forKey: "followers_count") as? Int ?? 0
                            let following = jsonData.value(forKey: "friends_count") as? Int ?? 0
                            self.url = profileImage
                            DispatchQueue.main.async {
                                self.userName.text = "@\(userName)"
                                self.screenName.text = name
                                let url = URL(string: profileImage)
                                let coverUrl = URL(string: bannerImage)
                                self.profileImg.kf.setImage(with:url)
                                self.profileImg.layer.cornerRadius = 25
                                self.coverImage.kf.setImage(with: coverUrl)
                                self.followerLb.text = "\(followers) Followers"
                                self.followingLb.text = "\(following) Following"
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
    
    @objc func followingPress()  {
        let vc = storyboard?.instantiateViewController(identifier: "FollowingVC") as! FollowingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func followerPress()  {
        let vc = storyboard?.instantiateViewController(identifier: "FollowerVC") as! FollowerVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
