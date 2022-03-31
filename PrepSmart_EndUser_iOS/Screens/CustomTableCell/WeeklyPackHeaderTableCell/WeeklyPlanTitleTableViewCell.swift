//
//  WeeklyPlanTitleTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 17/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class WeeklyPlanTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_header: CustomButton!
    @IBOutlet weak var arraowImageView: UIImageView!
    
    @IBOutlet weak var imgView_mealTime: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
