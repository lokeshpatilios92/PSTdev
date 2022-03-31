//
//  CurrentOrderItemTableViewCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket on 30/01/20.
//  Copyright © 2020 Exceptionaire.co. All rights reserved.
//

import UIKit

class CurrentOrderItemTableViewCell: UITableViewCell {

    @IBOutlet weak var view_checkBox: BEMCheckBox!
    @IBOutlet weak var lbl_itemName: UILabel!
    @IBOutlet weak var btn_expandCollapse: UIButton!
    @IBOutlet weak var btn_selectProduct: UIButton!
    @IBOutlet weak var lbl_selectProduct: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_itemNumber: UILabel!
    @IBOutlet weak var lbl_productId: UILabel!
    @IBOutlet weak var lbl_currentPrice: UILabel!
    @IBOutlet weak var lbl_qty: UILabel!
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var lbl_estimatedCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_checkBox.boxType = .square
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
