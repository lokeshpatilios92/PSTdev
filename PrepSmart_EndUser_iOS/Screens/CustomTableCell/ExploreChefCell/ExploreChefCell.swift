//
//  ExploreChefCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 02/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos

class ExploreChefCell: UITableViewCell {

    @IBOutlet weak var subscribersCountLbl: UILabel!
    @IBOutlet weak var blogsCountLbl: UILabel!
    @IBOutlet weak var recipesCountLbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var viewProfileBtn: UIButton!
    @IBOutlet weak var Lbl_name: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var subscribeBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       viewProfileBtn.layer.cornerRadius = 5
       subscribeBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
