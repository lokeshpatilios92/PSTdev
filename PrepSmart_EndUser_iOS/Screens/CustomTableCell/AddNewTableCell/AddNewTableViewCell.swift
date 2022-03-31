//
//  AddNewTableViewCell.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 05/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddNewTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView_radio: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_info: UIButton!
    @IBOutlet weak var sepraterLabel: UILabel!
    @IBOutlet weak var headerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
