//
//  MacroCounterTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 18/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class MacroCounterTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_macroCounter: UILabel!
    @IBOutlet weak var lbl_calories: UILabel!
    @IBOutlet weak var view_main: ConsultationTableViewCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_main.clipsToBounds = true
        view_main.layer.cornerRadius = 3.0
        view_main.layer.borderWidth = 0.5
        view_main.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
