//
//  WeeklyPackHeaderTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 14/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class WeeklyPackHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_arrow: UIButton!
    @IBOutlet weak var btn_header: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
