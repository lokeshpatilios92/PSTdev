//
//  FeedCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 02/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos

class FeedCell: UITableViewCell {

    @IBOutlet weak var forwardArrow: UIImageView!
    @IBOutlet weak var chefNameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imgContainerView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var commentsImageView: UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var commentsCountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        imgContainerView.layer.cornerRadius = imgContainerView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
