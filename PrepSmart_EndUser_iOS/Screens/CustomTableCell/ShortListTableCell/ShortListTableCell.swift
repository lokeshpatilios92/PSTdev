//
//  ShortListTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 07/11/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ShortListTableCell: UITableViewCell {
    @IBOutlet weak var sideImageView: UIImageView!
    @IBOutlet weak var lbl_itemTitle: UILabel!
    @IBOutlet var view_main: UIView!
    @IBOutlet var lbl_border: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_main.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
