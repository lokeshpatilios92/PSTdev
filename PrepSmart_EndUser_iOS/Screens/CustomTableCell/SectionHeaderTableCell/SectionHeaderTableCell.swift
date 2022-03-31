//
//  SectionHeaderTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 01/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SectionHeaderTableCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
