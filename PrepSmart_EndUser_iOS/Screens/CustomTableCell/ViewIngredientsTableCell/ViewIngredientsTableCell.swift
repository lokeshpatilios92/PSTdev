//
//  ViewIngredientsTableCell.swift
//  PrepSmart_ETPL
//
//  Created by Lalit Kandi on 21/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class ViewIngredientsTableCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftBottomView: UIView!
    @IBOutlet weak var rightBottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
