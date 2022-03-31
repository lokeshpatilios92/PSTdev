//
//  KeyFeaturesTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 01/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class KeyFeaturesTableCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bulletView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bulletView.layer.cornerRadius = bulletView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
