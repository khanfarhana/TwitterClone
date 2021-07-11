//
//  FollowerCell.swift
//  TwitterClone
//
//  Created by Farhana Khan on 10/07/21.
//

import UIKit

class FollowerCell: UITableViewCell {
    @IBOutlet weak var userNameLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var bioLb: UILabel!
    @IBOutlet weak var followerBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
