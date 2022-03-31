//
//  InstructionsHeaderTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 10/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class InstructionsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_add: UIButton!
    @IBOutlet weak var btn_header: UIButton!
    @IBOutlet weak var btn_arrow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btn_add.semanticContentAttribute = .forceRightToLeft
        btn_add.imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: -4.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
