//
//  YourItemsTableViewCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket ETPL on 12/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class YourItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel : UILabel!
    @IBOutlet weak var estimatedPriceLabel: UILabel!
    @IBOutlet weak var itemIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
