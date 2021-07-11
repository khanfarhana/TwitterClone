//
//  API.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import Foundation
import UIKit
class API {
    let authorization = "Bearer \("AAAAAAAAAAAAAAAAAAAAAHXqRQEAAAAA4ucG5vSGhWwoXLN6cw2ScGWfBnU%3Dwxi335NokqqvoOugjEiiLETMsii3i3ly0QYkwo17YAzsyw8XPd")"

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
}
