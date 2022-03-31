//
//  ViewInstructionSectionTableCell.swift
//  PrepSmart_ETPL
//
//  Created by Lalit Kandi on 24/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ViewInstructionSectionTableCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomSepreatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
