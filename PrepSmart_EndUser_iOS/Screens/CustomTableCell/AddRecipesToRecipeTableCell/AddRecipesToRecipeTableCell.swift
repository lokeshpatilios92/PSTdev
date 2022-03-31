//
//  AddRecipesToRecipeTableCell.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 20/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddRecipesToRecipeTableCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemInfoLable: UILabel!
    @IBOutlet weak var btn_addORdelete: UIButton!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var view_qty: UIView!
    @IBOutlet weak var lbl_servings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.itemImage.layer.cornerRadius = self.itemImage.frame.height / 2
    }
}
