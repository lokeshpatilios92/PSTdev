//
//  ExploreWeeklyPlanTemplatesCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos

class ExploreWeeklyPlanTemplatesCell: UICollectionViewCell {

    
    @IBOutlet var weeklyPlanView: UIView!
    @IBOutlet weak var itemImageView    : UIImageView!
    @IBOutlet weak var labelImageView0  : UIImageView!
    @IBOutlet weak var labelImageView1  : UIImageView!
    @IBOutlet weak var labelImageView2  : UIImageView!
    @IBOutlet weak var labelImageView3  : UIImageView!
    @IBOutlet weak var labelImageView4  : UIImageView!
    @IBOutlet weak var cosmosStarView   : CosmosView!
    @IBOutlet weak var ratingLabel      : UILabel!
    @IBOutlet weak var itemTitleLabel   : UILabel!
    @IBOutlet weak var bgView: UIView!
//    @IBOutlet var weeklyPlanBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weeklyPlanView.layer.cornerRadius = weeklyPlanView.frame.height/2
    }

}
