//
//  CookListIngredientsTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//
//Screen ID :-  PSTMOBSTD062

import UIKit

class CookListIngredientsTableCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leftCheckImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightCartImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
