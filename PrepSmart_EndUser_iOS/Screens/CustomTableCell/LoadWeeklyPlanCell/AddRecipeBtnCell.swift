//
//  AddRecipeBtnCell.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 10/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class AddRecipeBtnCell: UITableViewCell {

    @IBOutlet var addRecipeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       addRecipeBtn.layer.cornerRadius = addRecipeBtn.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
