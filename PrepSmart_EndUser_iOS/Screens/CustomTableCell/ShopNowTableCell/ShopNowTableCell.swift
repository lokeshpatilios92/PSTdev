//
//  ShopNowTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ShopNowTableCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leftImage: UIImageView!
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
