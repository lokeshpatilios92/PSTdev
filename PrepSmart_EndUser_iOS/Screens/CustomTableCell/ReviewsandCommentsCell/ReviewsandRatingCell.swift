//
//  ReviewsandRatingCell.swift
//  PrepSmart_ETPL
//
//  Created by Etpl-Mac on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import GTProgressBar

class ReviewsandRatingCell: UITableViewCell {

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var starPercentageLabel: UILabel!
    @IBOutlet weak var progressView: GTProgressBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
