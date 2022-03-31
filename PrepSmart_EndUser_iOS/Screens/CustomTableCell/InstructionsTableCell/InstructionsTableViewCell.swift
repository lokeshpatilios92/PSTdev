//
//  InstructionsTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class InstructionsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_stepName: UILabel!
    @IBOutlet weak var lbl_stepDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
