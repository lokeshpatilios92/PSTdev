//
//  ConsultationTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 29/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ConsultationTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView_profile: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var view_border: ConsultationTableViewCell!
    @IBOutlet weak var view_indicator: UIView!
    @IBOutlet weak var rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
