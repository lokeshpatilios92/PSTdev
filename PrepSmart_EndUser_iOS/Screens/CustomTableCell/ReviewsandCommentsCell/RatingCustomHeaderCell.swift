//
//  RatingCustomHeaderCell.swift
//  PrepSmart_ETPL
//
//  Created by Etpl-Mac on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Cosmos

class RatingCustomHeaderCell: UITableViewCell {

    @IBOutlet weak var dropDownImgView: UIImageView!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var ratingcountLbl: UILabel!
    @IBOutlet weak var sectionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
