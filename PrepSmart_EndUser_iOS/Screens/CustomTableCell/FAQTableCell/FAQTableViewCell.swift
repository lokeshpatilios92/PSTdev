//
//  FAQTableViewCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket on 05/02/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_question: UILabel!
    @IBOutlet weak var lbl_answer: UILabel!
    @IBOutlet weak var view_bottom: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
