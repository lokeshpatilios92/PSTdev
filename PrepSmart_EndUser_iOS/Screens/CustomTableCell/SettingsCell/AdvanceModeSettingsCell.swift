//
//  AdvanceModeSettingsCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 06/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AdvanceModeSettingsCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var switchSetting: UISwitch!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
