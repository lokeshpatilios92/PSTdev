//
//  EditRecipeFooterTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditRecipeFooterTableCell: UITableViewCell {

    @IBOutlet var lbl_subtitle: UILabel!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var btn_add: UIButton!
    @IBOutlet var view_macro: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_macro.layer.cornerRadius = 3.0
        view_macro.layer.borderWidth = 0.5
        view_macro.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
