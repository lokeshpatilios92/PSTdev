//
//  CommentsCell.swift
//  PrepSmart_ETPL
//
//  Created by Etpl-Mac on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos

class CommentsCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var helfulLabel: UILabel!
    @IBOutlet weak var notHelfulLabel: UILabel!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var helpfulButton: UIButton!
    @IBOutlet weak var notHelpFulButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        
        bgView.layer.cornerRadius = 5
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        bgView.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
