//
//  EditRecipeTableCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 16/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class EditRecipeTableCell: UITableViewCell {

    @IBOutlet weak var imgView_recipe: UIImageView!
    
    @IBOutlet weak var lbl_recipeName: UILabel!
    @IBOutlet weak var lbl_servings: UILabel!
    @IBOutlet weak var lbl_calories: UILabel!
    @IBOutlet weak var lbl_bottomSeparator: UILabel!
    @IBOutlet weak var itemCountLabel:UILabel!
    
    @IBOutlet weak var removeQutButton:UIButton!
    @IBOutlet weak var addQutButton:UIButton!
    
    @IBOutlet var btn_delete: UIButton!
    var itemCount = 1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
