//
//  KitchenTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh_ETPL on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class KitchenTableCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
